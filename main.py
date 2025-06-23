from sqlalchemy import create_engine, Column, Integer, String, Boolean, ForeignKey, JSON
from sqlalchemy.orm import relationship, sessionmaker, declarative_base
from sqlalchemy.orm import Session
from typing import List, Any
from fastapi import Depends, HTTPException, UploadFile, File, Form
import os
import azure.cognitiveservices.speech as speechsdk
from pydub import AudioSegment
from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()
SPEECH_KEY = os.getenv("SPEECH_KEY")
SPEECH_REGION = os.getenv("SPEECH_REGION")

USER = os.getenv("USER_DATABASE")
PASSWORD = os.getenv("PASSWORD_DATABASE")
ADDRESS = os.getenv("ADDRESS_DATABASE")
SCHEMA = os.getenv("SCHEMA_DATABASE")

client = OpenAI(
    # This is the default and can be omitted
    api_key=os.getenv("OPENAI_API_KEY"),
)

DATABASE_URL = f"mysql+pymysql://root:1234@localhost:3306/parlancio"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()

class UsuarioDB(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    mail = Column(String(150), unique=True, index=True, nullable=False)
    password = Column(String(30), nullable=False)
    level = Column(String(20), nullable=False)
    corrections = Column(String(20), nullable=False)
    language = Column(String(20), nullable=False)

    intereses = relationship("InteresDB", back_populates="usuario", uselist=False)

class InteresDB(Base):
    __tablename__ = "intereses"

    id = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.id"))
    
    videojuegos = Column(Boolean, default=False)
    peliculas = Column(Boolean, default=False)
    series = Column(Boolean, default=False)
    moda = Column(Boolean, default=False)
    travel = Column(Boolean, default=False)
    anime = Column(Boolean, default=False)
    ai = Column(Boolean, default=False)
    tecnologia = Column(Boolean, default=False)

    usuario = relationship("UsuarioDB", back_populates="intereses")

Base.metadata.create_all(bind=engine)

class ConversacionFront(Base):
    __tablename__ = "conversaciones_front"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), nullable=False)
    language = Column(String(10), nullable=False)
    level = Column(String(50), nullable=False)
    image = Column(String(500), nullable=True)

class ConversacionContent(Base):
    __tablename__ = "conversaciones_content"

    id = Column(Integer, primary_key=True, index=True)
    id_conversaciones_front = Column(Integer, nullable=False)
    content = Column(JSON, nullable=False)

class ViewUsersInterests(Base):
    __tablename__ = "vw_users_interests"

    id = Column(Integer, primary_key=True, index=True)
    mail = Column(String)
    password = Column(String)
    level = Column(String)
    corrections = Column(String)
    language = Column(String)
    videojuegos = Column(Boolean)
    peliculas = Column(Boolean)
    series = Column(Boolean)
    moda = Column(Boolean)
    travel = Column(Boolean)
    anime = Column(Boolean)
    ai = Column(Boolean)
    tecnologia = Column(Boolean)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

from fastapi import FastAPI

from pydantic import BaseModel

class Usuario(BaseModel):
    mail: str

class Interests(BaseModel):
    videojuegos: bool
    peliculas: bool
    series: bool
    moda: bool
    travel: bool

class UsuarioRegistro(BaseModel):
    mail: str
    password: str
    level: str
    corrections: str  # plural, igual que el JSON
    language: str
    interests: List[str]

class ConvoFront(BaseModel):
    id: int
    title: str
    language: str
    level: str
    image: str

class ConvoContent(BaseModel):
    id: int
    id_conversacion_front: str
    content: Any

class UsuarioLogin(BaseModel):
    mail: str
    password: str

class ConversationEval(BaseModel):
    message: str
    language: str
    audio: str

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hola": "Mundo"}

@app.post("/users/validate-mail")
def saludar(usuario: Usuario):
    return {"mensaje": f"Hola, {usuario.mail}!"}

@app.post("/users/login")
def login(usuario: UsuarioLogin, db: Session = Depends(get_db)):
    existente = db.query(ViewUsersInterests).filter(ViewUsersInterests.mail == usuario.mail, ViewUsersInterests.password == usuario.password).first()
    if not existente:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return existente

@app.get("/convos/get-front")
def getConvos(language: str, db: Session = Depends(get_db)):
    resultados = db.query(ConversacionFront).filter(ConversacionFront.language == language.lower()).all()
    if not resultados:
        raise HTTPException(status_code=404, detail="No se encontraron conversaciones para ese idioma")
    return resultados

@app.get("/convos/get-conversation")
def getConvos(id_conversaciones_front: int, db: Session = Depends(get_db)):
    resultados = db.query(ConversacionContent).filter(ConversacionContent.id_conversaciones_front == id_conversaciones_front).all()
    if not resultados:
        raise HTTPException(status_code=404, detail="No se encontro la conversacion")
    return resultados[0].content

@app.post("/users/sign-up")
def registrar(usuario: UsuarioRegistro, db: Session = Depends(get_db)):
    # Verificar si ya existe usuario con ese mail
    existente = db.query(UsuarioDB).filter(UsuarioDB.mail == usuario.mail).first()
    if existente:
        raise HTTPException(status_code=400, detail="El correo ya está registrado")

    # Crear objeto UsuarioDB
    nuevo_usuario = UsuarioDB(
        mail=usuario.mail,
        password=usuario.password,
        language=usuario.language,
        level=usuario.level,
        corrections=usuario.corrections,
    )
    db.add(nuevo_usuario)
    db.flush()  # Para que se genere el id y podamos usarlo en intereses

    # Crear intereses
    intereses_usuario = InteresDB(
        usuario_id=nuevo_usuario.id,
        videojuegos="videojuegos" in usuario.interests,
        peliculas="peliculas" in usuario.interests,
        series=False,  # Puedes ajustar si quieres
        moda="moda" in usuario.interests,
        travel="viajes" in usuario.interests,
        anime="anime" in usuario.interests,
        ai="ai" in usuario.interests,
        tecnologia="tecnologia" in usuario.interests,
    )
    db.add(intereses_usuario)
    db.commit()
    db.refresh(nuevo_usuario)
    existente = db.query(ViewUsersInterests).filter(ViewUsersInterests.mail == usuario.mail, ViewUsersInterests.password == usuario.password).first()
    if not existente:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return existente

    #return {"mensaje": f"Usuario {nuevo_usuario.mail} registrado exitosamente"}


@app.post("/convos/evaluate")
async def evaluate_pronunciation(
    file: UploadFile = File(...),
    reference_text: str = Form(...),
    language: str = Form("zh-CN")  # Valor por defecto
):
    try:
        # Validar formato de audio
        """if not file.filename.endswith(('.wav', '.mp3')):
            raise HTTPException(400, "Formato no soportado. Use WAV o MP3")"""

        # Guardar temporalmente
        temp_path = f"temp_{file.filename}"
        with open(temp_path, "wb") as buffer:
            content = await file.read()
            buffer.write(content)
        
        
        try:
            sound = AudioSegment.from_file(temp_path, format='m4a')
            output_path = "converted_audio.wav"
            
            # Exportar el archivo convertido
            sound.export(output_path, format='wav')
            
            print(f"Archivo original: {temp_path}")
            print(f"Tipo de contenido: {file.content_type}")
            print(f"Tamaño original: {len(content)} bytes")
            
            # 3. Opcional: eliminar el archivo temporal
            os.remove(temp_path)
            
            # Configurar Azure
            print(SPEECH_KEY)
            print(SPEECH_REGION)
            speech_config = speechsdk.SpeechConfig(subscription=SPEECH_KEY, region=SPEECH_REGION)
            speech_config.speech_recognition_language = language
            audio_config = speechsdk.audio.AudioConfig(filename=output_path)
            
            pronunciation_config = speechsdk.PronunciationAssessmentConfig(
                reference_text=reference_text,
                grading_system=speechsdk.PronunciationAssessmentGradingSystem.HundredMark,
                granularity=speechsdk.PronunciationAssessmentGranularity.Phoneme,
                enable_miscue=True
            )

            recognizer = speechsdk.SpeechRecognizer(speech_config, audio_config)
            pronunciation_config.apply_to(recognizer)

            result = recognizer.recognize_once()

            if result.reason == speechsdk.ResultReason.RecognizedSpeech:
                pronunciation_result = speechsdk.PronunciationAssessmentResult(result)
                # Resultados generales
                general_scores = {
                    "accuracy_score": pronunciation_result.accuracy_score,
                    "fluency_score": pronunciation_result.fluency_score,
                    "completeness_score": pronunciation_result.completeness_score,
                    "pronunciation_score": pronunciation_result.pronunciation_score
                }
                #print(pronunciation_result)
                # Resultados por palabra
                word_results = []
                for word in pronunciation_result.words:
                    word_results.append({
                        "word": word.word,
                        "accuracy_score": word.accuracy_score,
                        "error_type": word.error_type if word.error_type else None,
                    })
                
                return {
                    "general_scores": general_scores,
                    "word_results": word_results
                }
            else:
                raise HTTPException(400, "No se pudo evaluar el audio")
            
        except Exception as conv_error:
            # Asegurarse de eliminar el archivo temporal incluso si hay error
            if os.path.exists(temp_path):
                os.remove(temp_path)
            raise HTTPException(
                status_code=400, 
                detail=f"Error al convertir el audio: {str(conv_error)}"
            )

        

    except Exception as e:
        if 'temp_path' in locals() and os.path.exists(temp_path):
            os.remove(temp_path)
        raise HTTPException(500, str(e))
    
@app.post("/convos/create-convo")
async def evaluate_pronunciation(usuario: UsuarioRegistro):
    lenguaje = "chino"
    if usuario.language == "en":
        lenguaje = "ingles"
    elif usuario.language == "pt":
        lenguaje = "portugues"
    response = client.chat.completions.create(
        model="gpt-4o-mini",  # You can also use "gpt-3.5-turbo"
        messages=[
            {"role": "system", "content": f"""Crea una conversacion en el idioma {lenguaje} tomando en cuenta que el usuario esta interesado en {", ".join([x for x in usuario.interests])}, por lo tanto debes crear una conversacion relacionada con alguno de esos temas, el usuario es {usuario.level} en el lenguaje la conversacion tiene que llevar el siguiente formato y con al menos 10 mensajes en la conversacion: [
  {{
    "role": "服务员",
    "agent_type": "system",
    "message": "你好，欢迎光临！请问你要点什么？",
    "state": "done"
  }},
  {{
    "role": "顾客",
    "agent_type": "user",
    "message": "你好，我想要一杯咖啡。",
    "state": "wait"
  }},
  {{
    "role": "服务员",
    "agent_type": "system",
    "message": "好的，请问你要热的还是冰的？",
    "state": "hide"
  }},
  {{
    "role": "顾客",
    "agent_type": "user",
    "message": "我要热的，谢谢。",
    "state": "hide"
  }}
]
Siempre debe empezar el system y luego va el user y asi sucesivamente, el primer estado debe ser done en el system y wait en el user, no le cambies el nombre a los estados que se usan, siempre son done, wait y hide, y para los aget_type solo son system y user, el role lo puedes cambiar de acuerdo a la tematica de la conversacion y el lenguaje. Finalmente solo regresa el json y no digas nada mas"""},
            {"role": "user", "content": "Genera la conversacion, solo regresa el json"}
        ]
    )

    print(response.choices[0].message.content)
    return(response.choices[0].message.content)