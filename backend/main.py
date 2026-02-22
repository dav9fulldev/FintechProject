from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.models.database import engine, Base
from app.routes import auth, budgets, transactions, goals, ai, reports, planned_purchases

"""
Point d'entrée principal de l'API GèrTonArgent.
Ce fichier initialise FastAPI, configure la sécurité (CORS) et agrège les routes.
"""

# Créer toutes les tables
# Base.metadata.create_all(bind=engine)

# Initialisation de l'application FastAPI avec métadonnées pour Swagger/Redoc
app = FastAPI(
    title="GèrTonArgent API",
    description="Backend pour l'assistant financier intelligent - Gestion budgétaire avec IA",
    version="2.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Sécurité : Configuration du middleware CORS pour autoriser les appels depuis le Frontend
# Note : En production, il faudra restreindre allow_origins à l'URL réelle de l'app.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Architecture : Montage des différents modules fonctionnels de l'application
app.include_router(auth.router)
app.include_router(budgets.router)
app.include_router(transactions.router)
app.include_router(goals.router)
app.include_router(ai.router)
app.include_router(planned_purchases.router)

@app.get("/")
def read_root():
    """Route d'accueil simple pour vérifier que l'API répond."""
    return {
        "message": "Bienvenue sur l'API GèrTonArgent",
        "version": "2.0.0",
        "status": "running"
    }

@app.get("/health")
def health_check():
    """Route technique pour le monitoring (Docker/K8s)."""
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)




