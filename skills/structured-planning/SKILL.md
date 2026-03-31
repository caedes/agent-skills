---
name: structured-planning
description: Génère des plans de développement structurés et rigoureux pour les nouvelles fonctionnalités ou le refactoring. Ce skill impose une phase de clarification obligatoire (questions, identification des fichiers, évaluation de complexité) avant de produire un plan détaillé incluant l'objectif, les fichiers impactés, les étapes atomiques, les contrats d'interface, les tests (RTL/a11y), les risques et le hors-scope. À utiliser dès qu'une demande de feature ou de refactoring non triviale est reçue.
---

# Structured Planning

## Instructions pour l'Agent

Dès que tu reçois une demande de **nouvelle fonctionnalité (feature)** ou de **refactorisation (refactoring)**, tu dois suivre scrupuleusement ces deux phases.

### Phase 1 — Compréhension (boucle OBLIGATOIRE)

La Phase 1 est une boucle : tu poses des questions, tu reçois les réponses, tu
réévalues ton niveau de confiance, tu poses de nouvelles questions si nécessaire.
Tu ne passes à la Phase 2 que lorsque ton niveau de confiance atteint 95% ou plus.

Avant de proposer une implémentation, tu dois impérativement :

- Poser entre **5 à 10 questions numérotées** pour clarifier le besoin à chaque itération.
- Identifier les fichiers potentiellement impactés avec `@file`.
- Évaluer la complexité de la tâche (S/M/L/XL).
- Indiquer ton **niveau de confiance en %** sur ta compréhension du besoin après chaque salve de réponses.

### Phase 2 — Plan structuré

Une fois que ton niveau de confiance atteint **95% ou plus**, produis un plan détaillé structuré ainsi :

1. **Objectif** : Une seule phrase résumant ce qui sera livré.
2. **Fichiers impactés** : Liste ordonnée avec le chemin complet et l'action prévue (`create`/`modify`/`delete`).
3. **Étapes ordonnées** : Liste numérotée de tâches atomiques, chacune testable indépendamment.
4. **Contrat d'interface** : Définition des types TypeScript pour les entrées/sorties créées ou modifiées.
5. **Tests à écrire** : Liste des cas de test (React Testing Library, accessibilité inclus).
6. **Risques et edge cases** : Identification des points de rupture potentiels ou des effets de bord.
7. **Ce qu'on ne fait PAS** : Périmètre explicitement exclu (Principe YAGNI).

## Contraintes Techniques à Respecter

- **TypeScript Strict** : Utiliser des types explicites partout.
- **Logique React** : Extraire systématiquement la logique complexe dans des **custom hooks**.
- **Architecture** : Appliquer les principes **SOLID** et la **Clean Architecture**.
- **Data Fetching** : Utiliser **React Query** pour les appels API côté client.
- **Accessibilité** : Inclure des tests d'accessibilité systématiques.
- **Documentation** : Pas de commentaires superflus. Utiliser JSDoc uniquement si cela apporte une réelle valeur ajoutée au code.

## Format de Réponse

- Le plan est créé sous forme de fichier Markdown dans `.cursor/plans/<nom-feature>.md`
  (via un outil de création de fichier — Write ou équivalent). Il n'est PAS retranscrit
  dans le chat seul.
- Nommage du fichier : `kebab-case-descriptif-YYYY-MM-DD.md` (date du jour en suffixe ISO 8601), ex. `user-auth-refactor-2026-03-31.md`.
- Markdown concis, pas de prose inutile.
- Utiliser le **futur simple** ("On créera...", "On modifiera...").
- Le plan doit être autosuffisant et exécutable par un autre modèle sans contexte supplémentaire.
