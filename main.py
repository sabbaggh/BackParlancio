from sqlalchemy import create_engine, Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship, sessionmaker, declarative_base
from sqlalchemy import text
from sqlalchemy.orm import Session
from typing import List
from fastapi import Depends, HTTPException

DATABASE_URL = "mysql+pymysql://root:1234@localhost/parlancio"
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

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hola": "Mundo"}

@app.post("/users/validate-mail")
def saludar(usuario: Usuario):
    return {"mensaje": f"Hola, {usuario.mail}!"}

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
