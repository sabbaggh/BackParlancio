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
    corrections: str
    language: str
    interest: Interests

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hola": "Mundo"}

@app.post("/users/validate-mail")
def saludar(usuario: Usuario):
    return {"mensaje": f"Hola, {usuario.mail}!"}

@app.post("/users/sign-up")
def registrar(usuario: UsuarioRegistro):
    return {"mensaje": f"Usuario {usuario.mail} registrado"}
