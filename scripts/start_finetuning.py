import os
import time
from openai import OpenAI
from dotenv import load_dotenv

# Charger les variables d'environnement
load_dotenv(dotenv_path=r"c:\PROJET FINTECH\Gertonargent\Gertonargent_v2\backend\.env")

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def launch_finetuning():
    file_path = r"c:\PROJET FINTECH\Gertonargent\Gertonargent_v2\docs\fine_tuning_data.jsonl"
    
    if not os.path.exists(file_path):
        print(f"Erreur : Le fichier {file_path} n'existe pas.")
        return

    print(f"Telechargement du fichier : {file_path}")
    
    # 1. Upload du fichier
    with open(file_path, "rb") as f:
        response = client.files.create(
            file=f,
            purpose="fine-tune"
        )
    
    file_id = response.id
    print(f"Fichier uploade avec l'ID : {file_id}")
    
    # Attendre que le fichier soit traité
    print("Attente du traitement du fichier par OpenAI...")
    while True:
        file_status = client.files.retrieve(file_id).status
        if file_status == "processed":
            break
        time.sleep(5)
    
    print("Fichier pret pour le fine-tuning.")

    # 2. Lancement du job de fine-tuning
    print("Lancement du job de fine-tuning sur gpt-4o-mini-2024-07-18...")
    ft_job = client.fine_tuning.jobs.create(
        training_file=file_id,
        model="gpt-4o-mini-2024-07-18"
    )
    
    print(f"Job de fine-tuning cree avec l'ID : {ft_job.id}")
    print("Vous pouvez suivre l'avancement ici : https://platform.openai.com/finetuning")
    print("\nUne fois terminé, récupérez le 'FT Model ID' et mettez-le dans votre fichier .env")

if __name__ == "__main__":
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Erreur : OPENAI_API_KEY n'est pas définie dans le fichier .env")
    else:
        launch_finetuning()
