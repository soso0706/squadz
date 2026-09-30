# EPF RAG : assistant pour les cours de l'EPF

Chatbot qui répond aux questions des étudiants à partir des supports de cours de l'EPF, avec les sources citées.

**Équipe squaDZ**
- Solène : Déploiement Azure et configuration Open WebUI
- Yasmine : Base de connaissances, connexion LLM
- Adam : Gestion des accès, rôles et permissions

## Architecture

| Brique | Choix |
|---|---|
| Plateforme | Open WebUI (conteneur Docker) |
| Hébergement | Azure App Service, région Germany West Central |
| Stockage | Stockage persistant Azure (`/home`) |
| Embeddings | Locaux, `sentence-transformers/all-MiniLM-L6-v2` |
| Base vectorielle | ChromaDB (intégrée à Open WebUI) |
| LLM | GPT OSS 20B via Groq |

## Contenu du repo

- `infra/main.tf` : infrastructure Azure en Terraform (AzureRM), exportée depuis notre déploiement
- `config/azure-variables.json` : variables d'environnement de l'App Service
- `config/openwebui-config.json` : réglages généraux d'Open WebUI (embeddings, documents, authentification)
- `config/modele.json` : réglages du modèle (max tokens, effort de raisonnement, capacités, outils)

Les secrets (clé Groq, `WEBUI_SECRET_KEY`) ont été retirés et remplacés par `A_REMPLIR`.

## Lancer le projet

### 1. Déployer l'infrastructure sur Azure

Prérequis : Terraform, Azure CLI, un abonnement Azure.

1. Se connecter : `az login`
2. Dans `infra/main.tf` :
   - remplacer les valeurs `A_REMPLIR` (clé Groq, secret aléatoire)
   - changer le nom de l'App Service (les noms Azure sont uniques au niveau mondial)
   - adapter la région si besoin (notre compte Azure for Students n'autorisait que Germany West Central)
3. Depuis le dossier `infra` :
   - `terraform init`
   - `terraform plan`
   - `terraform apply`

### 2. Configurer Open WebUI

1. Ouvrir l'URL de l'app et créer un compte (le premier compte créé est administrateur).
2. Panneau d'administration → Paramètres → Base de données → importer `config/openwebui-config.json`.
3. Réglages → Connexions : renseigner la clé Groq.
4. Page Modèles → importer `config/modele.json`.
5. Créer une collection de connaissances, y ajouter des supports de cours, puis l'attacher au modèle.

Les cours de l'EPF ne sont pas inclus dans ce repo (droits de l'école).

## Choix techniques

- **Coût** : consommation réduite de 6 000 à environ 1 000 tokens par échange (max tokens à 500, raisonnement "low", outils agentiques désactivés).
- **Sécurité** : clé API uniquement côté serveur, authentification obligatoire, rôle "user" par défaut.
- **Persistance** : stockage Azure activé pour conserver la base (utilisateurs, conversations, documents) entre les redémarrages.

## Limites connues

- Quotas Groq gratuits partagés par toute l'équipe (requêtes et tokens par minute et par jour).
- Déploiement limité à certaines régions avec un compte Azure for Students.
