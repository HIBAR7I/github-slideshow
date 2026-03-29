# 🎬 Guide complet : Upload vidéo vers Google Drive

## 📋 Table des matières

1. [Introduction](#introduction)
2. [Prérequis](#prérequis)
3. [Configuration Google Cloud](#configuration-google-cloud)
4. [Installation](#installation)
5. [Utilisation](#utilisation)
6. [Résolution de problèmes](#résolution-de-problèmes)
7. [FAQ](#faq)

---

## 🎯 Introduction

Ce guide vous explique comment uploader automatiquement votre vidéo de présentation vers Google Drive en utilisant le script Ruby `upload_to_drive.rb`.

### Fonctionnalités

✅ Upload automatique vers Google Drive  
✅ Authentification OAuth2 sécurisée  
✅ Création de dossiers  
✅ Partage public optionnel  
✅ Liste des fichiers uploadés  
✅ Interface en ligne de commande intuitive  

---

## 🔧 Prérequis

### Logiciels requis

- **Ruby** (version 2.7 ou supérieure)
- **Bundler** (gestionnaire de gems Ruby)
- **Connexion Internet**
- **Compte Google**

### Vérifier l'installation de Ruby

```bash
ruby --version
```

Si Ruby n'est pas installé :
- **Windows** : Téléchargez [RubyInstaller](https://rubyinstaller.org/)
- **macOS** : `brew install ruby`
- **Linux** : `sudo apt-get install ruby-full` (Ubuntu/Debian)

### Installer Bundler

```bash
gem install bundler
```

---

## ☁️ Configuration Google Cloud

### Étape 1 : Créer un projet Google Cloud

1. Allez sur [Google Cloud Console](https://console.cloud.google.com/)
2. Cliquez sur **"Sélectionner un projet"** → **"Nouveau projet"**
3. Donnez un nom à votre projet (ex: "Raouhi-Video-Upload")
4. Cliquez sur **"Créer"**

### Étape 2 : Activer l'API Google Drive

1. Dans le menu de gauche, allez dans **"API et services"** → **"Bibliothèque"**
2. Recherchez **"Google Drive API"**
3. Cliquez sur **"Google Drive API"**
4. Cliquez sur **"Activer"**

### Étape 3 : Créer des identifiants OAuth 2.0

1. Allez dans **"API et services"** → **"Identifiants"**
2. Cliquez sur **"Créer des identifiants"** → **"ID client OAuth"**
3. Si demandé, configurez l'écran de consentement :
   - Type d'utilisateur : **Externe**
   - Nom de l'application : **"Raouhi Video Uploader"**
   - Email d'assistance : Votre email
   - Cliquez sur **"Enregistrer et continuer"**
   - Portées : Laissez par défaut, cliquez sur **"Enregistrer et continuer"**
   - Utilisateurs test : Ajoutez votre email
   - Cliquez sur **"Enregistrer et continuer"**

4. Revenez à **"Identifiants"** → **"Créer des identifiants"** → **"ID client OAuth"**
5. Type d'application : **"Application de bureau"**
6. Nom : **"Raouhi Video Uploader Desktop"**
7. Cliquez sur **"Créer"**

### Étape 4 : Télécharger le fichier credentials

1. Une fenêtre s'ouvre avec vos identifiants
2. Cliquez sur **"Télécharger JSON"**
3. Renommez le fichier téléchargé en **`credentials.json`**
4. Placez ce fichier dans le dossier de votre projet (même dossier que `upload_to_drive.rb`)

⚠️ **IMPORTANT** : Ne partagez JAMAIS ce fichier ! Il contient vos clés d'accès.

---

## 📦 Installation

### Étape 1 : Installer les dépendances Ruby

Ouvrez un terminal dans le dossier du projet et exécutez :

```bash
bundle install
```

Cette commande installe automatiquement :
- `google-api-client` : Pour interagir avec l'API Google Drive
- `googleauth` : Pour l'authentification OAuth2

### Étape 2 : Vérifier l'installation

```bash
ruby upload_to_drive.rb
```

Si tout est bien configuré, vous verrez le menu principal.

---

## 🚀 Utilisation

### Première utilisation : Autorisation

La première fois que vous lancez le script, vous devez autoriser l'application :

1. Lancez le script :
   ```bash
   ruby upload_to_drive.rb
   ```

2. Une URL s'affiche dans le terminal
3. Copiez cette URL et ouvrez-la dans votre navigateur
4. Connectez-vous avec votre compte Google
5. Autorisez l'application (cliquez sur "Autoriser")
6. Copiez le code d'autorisation affiché
7. Collez-le dans le terminal et appuyez sur Entrée

✅ L'autorisation est enregistrée dans `token.yaml` et ne sera plus demandée.

### Upload d'une vidéo

#### Méthode 1 : Menu interactif

```bash
ruby upload_to_drive.rb
```

Choisissez l'option **1** (Uploader une vidéo), puis :
- Entrez le chemin complet de votre vidéo
- Ou laissez vide pour chercher automatiquement `presentation-raouhi-nada.webm`

#### Méthode 2 : Ligne de commande directe

Vous pouvez modifier le script pour un upload direct. Ajoutez à la fin du fichier `upload_to_drive.rb` :

```ruby
# Upload direct (décommentez pour utiliser)
# uploader = DriveUploader.new
# uploader.upload_file('chemin/vers/votre/video.webm')
```

### Créer un dossier

```bash
ruby upload_to_drive.rb
```

Choisissez l'option **2** et entrez le nom du dossier.

### Lister vos fichiers

```bash
ruby upload_to_drive.rb
```

Choisissez l'option **3** pour voir tous vos fichiers vidéo sur Drive.

---

## 🎨 Utilisation de l'interface HTML

### Ouvrir l'interface

Double-cliquez sur **`upload-drive.html`** pour ouvrir l'interface visuelle.

⚠️ **Note** : L'interface HTML est une démonstration visuelle. Pour uploader réellement, utilisez le script Ruby dans le terminal.

### Fonctionnalités de l'interface

- 📁 Sélection de fichier avec aperçu
- 📊 Barre de progression (simulation)
- 🔗 Affichage du lien Drive
- 📋 Instructions de configuration

---

## 🔧 Résolution de problèmes

### Erreur : "credentials.json introuvable"

**Solution** :
1. Vérifiez que le fichier `credentials.json` est dans le même dossier que `upload_to_drive.rb`
2. Vérifiez le nom du fichier (pas d'espace, pas de majuscules)
3. Retéléchargez le fichier depuis Google Cloud Console si nécessaire

### Erreur : "gem not found"

**Solution** :
```bash
bundle install
```

Si ça ne marche pas :
```bash
gem install google-api-client googleauth
```

### Erreur d'autorisation

**Solution** :
1. Supprimez le fichier `token.yaml`
2. Relancez le script
3. Refaites l'autorisation

### Upload échoue

**Causes possibles** :
- ❌ Connexion Internet coupée
- ❌ Fichier trop volumineux (limite : 5 TB pour Drive)
- ❌ Quota API dépassé (rare)

**Solution** :
1. Vérifiez votre connexion Internet
2. Réessayez plus tard
3. Vérifiez les quotas dans Google Cloud Console

### Erreur : "Invalid grant"

**Solution** :
1. Supprimez `token.yaml`
2. Relancez le script et refaites l'autorisation
3. Vérifiez que votre compte Google est actif

---

## ❓ FAQ

### Q : Combien de vidéos puis-je uploader ?

**R** : Illimité, tant que vous avez de l'espace sur votre Google Drive (15 GB gratuit, ou plus avec Google One).

### Q : Quelle est la taille maximale d'une vidéo ?

**R** : Google Drive accepte jusqu'à 5 TB par fichier.

### Q : Puis-je uploader d'autres types de fichiers ?

**R** : Oui ! Le script détecte automatiquement le type de fichier. Vous pouvez uploader :
- Vidéos : `.webm`, `.mp4`, `.avi`, `.mov`, `.mkv`, `.flv`, `.wmv`
- Images, documents, etc.

### Q : Comment rendre ma vidéo publique ?

**R** : Le script vous demande automatiquement après l'upload. Répondez "o" (oui) pour rendre la vidéo publique.

### Q : Puis-je uploader dans un dossier spécifique ?

**R** : Oui ! Créez d'abord un dossier (option 2), notez son ID, puis modifiez le script pour utiliser cet ID.

### Q : Le fichier `token.yaml` est-il sécurisé ?

**R** : Oui, mais ne le partagez jamais. Il contient votre token d'accès. Ajoutez-le à `.gitignore` si vous utilisez Git.

### Q : Puis-je automatiser l'upload ?

**R** : Oui ! Créez un script qui appelle `upload_to_drive.rb` avec les bons paramètres. Exemple :

```bash
#!/bin/bash
ruby upload_to_drive.rb --file "presentation-raouhi-nada.webm" --auto
```

### Q : Comment convertir ma vidéo en MP4 ?

**R** : Utilisez FFmpeg :
```bash
ffmpeg -i presentation-raouhi-nada.webm -c:v libx264 -c:a aac presentation-raouhi-nada.mp4
```

### Q : Puis-je uploader depuis un autre ordinateur ?

**R** : Oui, mais vous devrez refaire l'autorisation sur chaque ordinateur (ou copier `token.yaml`).

---

## 🔐 Sécurité

### Fichiers sensibles

Ne partagez JAMAIS ces fichiers :
- ❌ `credentials.json` : Vos identifiants OAuth
- ❌ `token.yaml` : Votre token d'accès

### Ajouter à .gitignore

Si vous utilisez Git, ajoutez ces lignes à `.gitignore` :

```
credentials.json
token.yaml
*.webm
*.mp4
```

### Révoquer l'accès

Pour révoquer l'accès de l'application :
1. Allez sur [myaccount.google.com/permissions](https://myaccount.google.com/permissions)
2. Trouvez "Raouhi Video Uploader"
3. Cliquez sur "Supprimer l'accès"

---

## 📚 Ressources supplémentaires

- [Documentation Google Drive API](https://developers.google.com/drive/api/v3/about-sdk)
- [Ruby Google API Client](https://github.com/googleapis/google-api-ruby-client)
- [OAuth 2.0 pour applications de bureau](https://developers.google.com/identity/protocols/oauth2/native-app)

---

## 🎉 Félicitations !

Vous êtes maintenant prêt à uploader vos vidéos vers Google Drive automatiquement !

### Workflow complet

1. **Créer la vidéo** : Ouvrez `avatar-presentation.html` et enregistrez
2. **Uploader vers Drive** : Lancez `ruby upload_to_drive.rb`
3. **Partager** : Copiez le lien et partagez sur les réseaux sociaux !

---

## 💡 Astuces avancées

### Upload automatique après création de vidéo

Créez un script `create_and_upload.sh` :

```bash
#!/bin/bash
echo "🎬 Création de la vidéo..."
# Ouvrir le navigateur pour créer la vidéo
open avatar-presentation.html

echo "⏳ Attendez que la vidéo soit créée..."
echo "Appuyez sur Entrée quand la vidéo est prête..."
read

echo "📤 Upload vers Google Drive..."
ruby upload_to_drive.rb
```

### Notification après upload

Ajoutez à la fin de `upload_to_drive.rb` :

```ruby
# Envoyer une notification (macOS)
system("osascript -e 'display notification \"Vidéo uploadée !\" with title \"Google Drive\"'")
```

---

**🌟 Bonne chance avec vos vidéos, Raouhi ! 🌟**

*L'art et la technologie se rencontrent pour créer quelque chose de magnifique.* ✨
