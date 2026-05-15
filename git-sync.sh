#!/bin/zsh

# Script per gestire Commit e Push velocemente
# Utilizzo: ./git-sync.sh "Messaggio del commit" [nome-branch]

MESSAGE=$1
BRANCH=$2

# Se il messaggio è vuoto, usa un default
if [ -z "$MESSAGE" ]; then
    MESSAGE="Aggiornamento automatico: $(date '+%Y-%m-%d %H:%M:%S')"
fi

# Se il branch non è specificato, usa quello attuale
if [ -z "$BRANCH" ]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

echo "🚀 Inizio sincronizzazione sul branch: $BRANCH..."

# 1. Aggiunge tutti i file (tranne quelli nel .gitignore)
git add .

# 2. Esegue il commit
if git commit -m "$MESSAGE"; then
    echo "✅ Commit effettuato: $MESSAGE"
else
    echo "⚠️ Nulla da committare (nessuna modifica rilevata)."
fi

# 3. Carica su GitHub
echo "📤 Invio su GitHub..."
if git push origin "$BRANCH"; then
    echo "🎉 Tutto sincronizzato correttamente su GitHub!"
else
    echo "❌ Errore durante il push. Controlla la connessione o il token."
    exit 1
fi
