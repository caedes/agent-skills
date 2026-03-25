#!/bin/bash

# Script pour récupérer le diff entre la branche courante (ou spécifiée) et origin/develop
# Usage: ./get-diff.sh [MY-BRANCH-NAME]

# Récupérer le nom de la branche (argument 1 ou branche courante)
BRANCH_NAME=${1:-$(git branch --show-current)}

if [ -z "$BRANCH_NAME" ]; then
  echo "Erreur : Impossible de déterminer le nom de la branche."
  exit 1
fi

# Fetch pour s'assurer d'avoir les dernières références
git fetch origin > /dev/null 2>&1

# Vérifier si origin/develop existe
if ! git rev-parse --verify origin/develop > /dev/null 2>&1; then
  echo "Erreur : La branche origin/develop est introuvable."
  exit 1
fi

# Déterminer la cible (priorité à la branche distante origin/$BRANCH_NAME)
if git rev-parse --verify "origin/$BRANCH_NAME" > /dev/null 2>&1; then
  TARGET="origin/$BRANCH_NAME"
else
  # Si pas sur origin, on tente en local
  if git rev-parse --verify "$BRANCH_NAME" > /dev/null 2>&1; then
    TARGET="$BRANCH_NAME"
  else
    echo "Erreur : La branche $BRANCH_NAME est introuvable (ni localement ni sur origin)."
    exit 1
  fi
fi

# Exécuter le diff avec les exclusions demandées
git diff "origin/develop...$TARGET" \
  ':(exclude)package-lock.json' \
  ':(exclude)*.{svg,png,jpg,jpeg,gif,webp,ico,bmp}' \
  ':(exclude)*.md'
