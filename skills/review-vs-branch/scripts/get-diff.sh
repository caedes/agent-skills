#!/bin/bash

# Script pour récupérer le diff entre une branche cible (défaut: origin/develop)
# et la branche source (défaut: branche courante).
#
# Usage: ./get-diff.sh [TARGET_BRANCH] [SOURCE_BRANCH]

# Récupérer la branche cible (argument 1 ou develop)
TARGET_BRANCH=${1:-develop}

# Récupérer la branche source (argument 2 ou branche courante)
SOURCE_BRANCH=${2:-$(git branch --show-current)}

if [ -z "$TARGET_BRANCH" ]; then
  echo "Erreur : Impossible de déterminer le nom de la branche cible."
  exit 1
fi

if [ -z "$SOURCE_BRANCH" ]; then
  echo "Erreur : Impossible de déterminer le nom de la branche source."
  exit 1
fi

# Fetch pour s'assurer d'avoir les dernières références
git fetch origin > /dev/null 2>&1

# Vérifier et normaliser la cible (priorité à origin/TARGET_BRANCH)
if git rev-parse --verify "origin/$TARGET_BRANCH" > /dev/null 2>&1; then
  TARGET_REF="origin/$TARGET_BRANCH"
else
  # Fallback local si la branche n'existe pas sur origin
  if git rev-parse --verify "$TARGET_BRANCH" > /dev/null 2>&1; then
    TARGET_REF="$TARGET_BRANCH"
  else
    echo "Erreur : La branche cible '$TARGET_BRANCH' est introuvable (ni localement ni sur origin)."
    exit 1
  fi
fi

# Déterminer la source (priorité à la branche distante origin/$SOURCE_BRANCH)
if git rev-parse --verify "origin/$SOURCE_BRANCH" > /dev/null 2>&1; then
  SOURCE_REF="origin/$SOURCE_BRANCH"
else
  # Si pas sur origin, on tente en local
  if git rev-parse --verify "$SOURCE_BRANCH" > /dev/null 2>&1; then
    SOURCE_REF="$SOURCE_BRANCH"
  else
    echo "Erreur : La branche source '$SOURCE_BRANCH' est introuvable (ni localement ni sur origin)."
    exit 1
  fi
fi

# Exécuter le diff avec les exclusions demandées
git diff "$TARGET_REF...$SOURCE_REF" \
  ':(exclude)package-lock.json' \
  ':(exclude)yarn.lock' \
  ':(exclude)*.{svg,png,jpg,jpeg,gif,webp,ico,bmp}' \
  ':(exclude)*.md' \
  ':(exclude,glob)**/*.snap'
