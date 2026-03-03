import pandas as pd
import json
import os
import random

# Configuration des chemins
BASE_DIR = r"c:\PROJET FINTECH\Gertonargent\Gertonargent_v2"
DATA_DIR = os.path.join(BASE_DIR, "docs", "jeux_de_donnees")
OUTPUT_FILE = os.path.join(BASE_DIR, "docs", "fine_tuning_data.jsonl")

SYSTEM_PROMPT = (
    "Tu es Sika, un coach financier intelligent et bienveillant pour l'application Gertonargent. "
    "Ton rôle est d'aider l'utilisateur à catégoriser ses d\u00e9penses, analyser ses habitudes financi\u00e8res, "
    "d\u00e9tecter les d\u00e9penses impulsives et fournir des conseils budg\u00e9taires personnalis\u00e9s en C\u00f4te d'Ivoire. "
    "Tu parles de mani\u00e8re naturelle, tu connais le vocabulaire local (gbaka, w\u00f4r\u00f4-w\u00f4r\u00f4, garba, maquis) "
    "et tu sais convertir les montants en 'francs cfa' pour une meilleure lecture par la voix. "
    "Tu ma\u00eetrices aussi le march\u00e9 financier de la BRVM."
)

def create_chat_example(user_content, assistant_content):
    return {
        "messages": [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": user_content},
            {"role": "assistant", "content": assistant_content}
        ]
    }

def process_personal_transactions():
    examples = []
    file_path = os.path.join(DATA_DIR, "personal_transactions.csv")
    if not os.path.exists(file_path):
        return []
    
    df = pd.read_csv(file_path)
    # Exemple de catégorisation enrichie
    for _, row in df.sample(min(40, len(df))).iterrows():
        desc = row['Description']
        amt = int(float(row['Amount']))
        cat = row['Category']
        
        user_msg = f"Sika, j'ai pay\u00e9 {amt} pour {desc}. C'est quoi comme cat\u00e9gorie ?"
        ast_msg = f"J'ai not\u00e9 \u00e7a David ! {amt} francs cfa pour {desc}, \u00e7a rentre dans la cat\u00e9gorie '{cat}'."
        examples.append(create_chat_example(user_msg, ast_msg))
    
    return examples

def process_budgetwise_notes():
    examples = []
    file_path = os.path.join(DATA_DIR, "budgetwise_finance_dataset.csv")
    if not os.path.exists(file_path):
        return []
    
    df = pd.read_csv(file_path)
    # Utiliser la colonne 'notes' pour des exemples plus naturels
    df_clean = df.dropna(subset=['notes', 'category', 'amount'])
    for _, row in df_clean.sample(min(30, len(df_clean))).iterrows():
        note = row['notes']
        amt = row['amount']
        cat = row['category']
        
        if note and note != 'N/A' and len(str(note)) > 3:
            user_msg = f"Sika, enregistre {note} pour un montant de {amt}."
            ast_msg = f"C'est fait ! J'ai ajout\u00e9 {amt} francs cfa pour '{note}' dans ta cat\u00e9gorie {cat}."
            examples.append(create_chat_example(user_msg, ast_msg))
            
    return examples

def process_budget_analysis():
    examples = []
    budget_file = os.path.join(DATA_DIR, "Budget.csv")
    if not os.path.exists(budget_file):
        return []
    
    df_budget = pd.read_csv(budget_file)
    budget_dict = df_budget.set_index('Category')['Budget'].to_dict()
    
    cats = list(budget_dict.keys())
    for _ in range(15):
        cat = random.choice(cats)
        limit = budget_dict[cat]
        spent = limit * random.uniform(0.5, 1.5)
        spent = int(spent)
        
        user_msg = f"Sika, j'ai d\u00e9pens\u00e9 {spent} pour '{cat}'. Mon budget est de {limit}. Qu'en penses-tu ?"
        if spent > limit:
            ast_msg = f"Attention David, tu as d\u00e9pass\u00e9 ton budget pour '{cat}' de {spent-limit} francs cfa. Il serait sage de r\u00e9duire tes d\u00e9penses!"
        else:
            ast_msg = f"C'est parfait ! Tu es encore dans ton budget pour '{cat}'. Il te reste {limit-spent} francs cfa \u00e0 d\u00e9penser."
        examples.append(create_chat_example(user_msg, ast_msg))
        
    return examples

def process_brvm_data():
    examples = []
    brvm_tips = [
        ("Qu'est-ce que la BRVM ?", "La BRVM est la Bourse R\u00e9gionale des Valeurs Mobili\u00e8res, bas\u00e9e \u00e0 Abidjan. Elle regroupe 8 pays de l'UEMOA."),
        ("Pourquoi investir en dividendes \u00e0 la BRVM ?", "L'investissement en dividendes permet de g\u00e9n\u00e9rer des revenus passifs r\u00e9guliers. Des entreprises comme Sonatel ou Ecobank CI sont connues pour leurs dividendes."),
        ("Comment commencer \u00e0 investir ?", "Il faut d'abord ouvrir un compte titres aupr\u00e8s d'une SGI (Soci\u00e9t\u00e9 de Gestion et d'Interm\u00e9diation).")
    ]
    for u, a in brvm_tips:
        examples.append(create_chat_example(u, a))
    return examples

def process_ivoirian_context():
    ivoirian_examples = [
        ("Sika, j'ai pris un w\u00f4r\u00f4 pour 500", "Tr\u00e8s bien ! J'ai not\u00e9 cinq cents francs cfa pour ton transport en w\u00f4r\u00f4-w\u00f4r\u00f4."),
        ("J'ai mang\u00e9 un garba \u00e0 1000", "Super ! J'ai enregistr\u00e9 mille francs cfa en alimentation pour ton garba."),
        ("j'ai fait un garba 1500", "Pas de soucis ! J'ai not\u00e9 mille cinq cents francs cfa pour ton garba. Cat\u00e9gorie alimentation / restauration rapide."),
        ("Je peux aller au maquis avec 15000 ?", "Hmm David, quinze mille francs cfa au maquis c'est possible, mais n'oublie pas ton budget loisirs !"),
        ("Sika, ajoute 2000 pour le cr\u00e9dit Orange", "C'est not\u00e9 ! Deux mille francs cfa de cr\u00e9dit communication ajout\u00e9s.")
    ]
    return [create_chat_example(u, a) for u, a in ivoirian_examples]

def main():
    all_examples = []
    all_examples.extend(process_personal_transactions())
    all_examples.extend(process_budgetwise_notes())
    all_examples.extend(process_budget_analysis())
    all_examples.extend(process_brvm_data())
    all_examples.extend(process_ivoirian_context())
    
    random.shuffle(all_examples)
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        for ex in all_examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
            
    print(f"Fichier de fine-tuning g\u00e9n\u00e9r\u00e9 : {OUTPUT_FILE}")
    print(f"Total des exemples : {len(all_examples)}")

if __name__ == "__main__":
    main()
