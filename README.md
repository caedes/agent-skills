# Agent Skills

> Propulsé par [skills](https://github.com/vercel-labs/skills)

Ce dépôt centralise mes compétences (Agent Skills) personnalisées pour les agents de codage IA dans Cursor. Il permet de structurer et de réutiliser des workflows complexes, des règles de linter personnalisées, ou des processus de revue de code.

## Installation

Pour installer ces compétences dans votre projet Cursor, utilisez la commande suivante :

```bash
npx skills add caedes/agent-skills
```

## Skills disponibles

### Produit & Lead Tech

- [**structured-planning**](./skills/structured-planning/SKILL.md) : Génère des plans de développement structurés et rigoureux pour les nouvelles fonctionnalités ou le refactoring.

### Développement & QA

- [**review-vs-branch**](./skills/review-vs-branch/SKILL.md) : Réalise une code review approfondie de la branche courante par rapport à une branche cible (par défaut `develop`).

> Cette structure est pensée pour évoluer vers des regroupements complémentaires par blocs de responsabilités (ex. produit, développement, QA, architecture) au fur et à mesure de l'ajout de nouveaux skills.
