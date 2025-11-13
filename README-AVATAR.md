# 🎨 Présentation Vidéo avec Avatar - Raouhi Nada

## 📋 Description

Cette application web interactive crée une présentation vidéo avec un avatar féminin portant le hijab qui lit automatiquement votre texte de présentation en français.

## ✨ Fonctionnalités

- **Avatar animé** : Un avatar féminin avec hijab créé en SVG
- **Synthèse vocale** : Lecture automatique du texte en français avec voix féminine
- **Animations** : L'avatar s'anime pendant la lecture (effet de pulsation)
- **Enregistrement vidéo** : Possibilité d'enregistrer la présentation en vidéo
- **Design moderne** : Interface responsive avec dégradés et animations CSS
- **Contrôles intuitifs** : Boutons pour démarrer, arrêter et enregistrer

## 🚀 Utilisation

### Option 1 : Ouvrir directement dans un navigateur

1. Ouvrez le fichier `avatar-presentation.html` dans votre navigateur web (Chrome, Firefox, Edge, Safari)
2. Cliquez sur **"▶️ Démarrer la présentation"** pour lancer la lecture vocale
3. L'avatar s'animera pendant que le texte est lu à voix haute

### Option 2 : Avec un serveur local

```bash
# Avec Python
python3 -m http.server 8000

# Avec Node.js
npx http-server -p 8000

# Avec PHP
php -S localhost:8000
```

Puis ouvrez : `http://localhost:8000/avatar-presentation.html`

## 🎥 Enregistrer une vidéo

1. Cliquez sur **"🎥 Enregistrer la vidéo"**
2. Sélectionnez l'onglet ou l'écran à enregistrer dans la fenêtre qui s'ouvre
3. Cochez "Partager l'audio" pour inclure la voix
4. La présentation démarrera automatiquement après 2 secondes
5. La vidéo sera téléchargée automatiquement à la fin

**Note** : L'enregistrement nécessite un navigateur moderne (Chrome, Edge, Firefox) et fonctionne mieux sur un ordinateur de bureau.

## 🔧 Configuration de la voix

La synthèse vocale utilise l'API Web Speech du navigateur. Pour de meilleurs résultats :

### Sur Windows
- Installez des voix françaises via **Paramètres > Heure et langue > Voix**
- Recommandé : "Microsoft Hortense" ou "Microsoft Julie"

### Sur macOS
- Allez dans **Préférences Système > Accessibilité > Contenu énoncé**
- Téléchargez des voix françaises (Amélie, Thomas, etc.)

### Sur Linux
- Installez `espeak` ou `festival` avec support français
```bash
sudo apt-get install espeak espeak-data
```

### Sur Chrome/Edge
- Les voix système sont utilisées automatiquement
- Chrome offre également des voix en ligne de haute qualité

## 🎨 Personnalisation

### Modifier le texte

Éditez la variable `presentationText` dans le fichier HTML (ligne ~180) :

```javascript
const presentationText = `Votre nouveau texte ici...`;
```

### Modifier l'apparence de l'avatar

Le SVG de l'avatar se trouve dans la section `<svg class="avatar-svg">` (ligne ~150). Vous pouvez :
- Changer les couleurs du hijab (attribut `fill`)
- Modifier les traits du visage
- Ajuster la taille avec les attributs `width` et `height`

### Modifier les couleurs du thème

Dans la section `<style>`, modifiez les gradients :

```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Ajuster la vitesse de lecture

Dans la fonction `startPresentation()` (ligne ~200) :

```javascript
currentUtterance.rate = 0.9;  // Vitesse (0.1 à 2.0)
currentUtterance.pitch = 1.1; // Tonalité (0 à 2)
```

## 📱 Compatibilité

| Navigateur | Synthèse vocale | Enregistrement vidéo |
|------------|----------------|---------------------|
| Chrome     | ✅ Excellent    | ✅ Oui              |
| Edge       | ✅ Excellent    | ✅ Oui              |
| Firefox    | ✅ Bon          | ✅ Oui              |
| Safari     | ⚠️ Limité      | ❌ Non              |
| Mobile     | ⚠️ Variable    | ❌ Non              |

## 🐛 Résolution des problèmes

### La voix ne fonctionne pas
- Vérifiez que le son de votre ordinateur n'est pas coupé
- Essayez un autre navigateur (Chrome recommandé)
- Installez des voix françaises sur votre système
- Ouvrez la console du navigateur (F12) pour voir les erreurs

### L'enregistrement ne démarre pas
- Assurez-vous d'utiliser Chrome ou Edge
- Autorisez le partage d'écran quand demandé
- Cochez "Partager l'audio" dans la fenêtre de sélection
- Essayez de sélectionner l'onglet spécifique plutôt que l'écran entier

### L'avatar ne s'anime pas
- Vérifiez que JavaScript est activé
- Actualisez la page (F5)
- Essayez en navigation privée pour éliminer les extensions

### La vidéo ne se télécharge pas
- Vérifiez les paramètres de téléchargement de votre navigateur
- Autorisez les téléchargements automatiques pour ce site
- Vérifiez l'espace disque disponible

## 🌟 Améliorations possibles

Pour aller plus loin, vous pourriez :

1. **Utiliser une API de synthèse vocale professionnelle** :
   - Google Cloud Text-to-Speech
   - Amazon Polly
   - Microsoft Azure Speech

2. **Ajouter des animations plus complexes** :
   - Mouvement des lèvres synchronisé
   - Expressions faciales
   - Gestes des mains

3. **Intégrer des sous-titres** :
   - Affichage du texte en temps réel
   - Surlignage du texte en cours de lecture

4. **Ajouter de la musique de fond** :
   - Musique marocaine traditionnelle
   - Effets sonores

5. **Créer plusieurs avatars** :
   - Différents styles de hijab
   - Différentes couleurs
   - Différentes expressions

## 📄 Licence

Ce projet est libre d'utilisation pour des projets personnels et éducatifs.

## 👩‍🎨 À propos

Créé pour Raouhi Nada, une jeune artiste passionnée de 14 ans du Maroc.

---

**Bon courage dans ta carrière artistique ! 🎨✨**
