from sqlalchemy import create_engine, Column, Integer, String, Boolean, ForeignKey, JSON
from sqlalchemy.orm import relationship, sessionmaker, declarative_base
from sqlalchemy import text
from sqlalchemy.orm import Session
from typing import List, Any
from fastapi import Depends, HTTPException

DATABASE_URL = "mysql+pymysql://root:juanin+3@localhost/parlancio"
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

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hola": "Mundo"}

@app.post("/users/validate-mail")
def saludar(usuario: Usuario):
    return {"mensaje": f"Hola, {usuario.mail}!"}

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
        videojuegos="Videojuegos" in usuario.interests,
        peliculas="Peliculas" in usuario.interests,
        series=False,  # Puedes ajustar si quieres
        moda="Moda" in usuario.interests,
        travel="Viajes" in usuario.interests,
        anime="Anime" in usuario.interests,
        ai="AI" in usuario.interests,
        tecnologia="Tecnologia" in usuario.interests,
    )
    db.add(intereses_usuario)
    db.commit()
    db.refresh(nuevo_usuario)

    return {"mensaje": f"Usuario {nuevo_usuario.mail} registrado exitosamente"}
