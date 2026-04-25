# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of custom AI agent skills (slash commands) for Claude Code and compatible AI coding tools. Skills are distributed via:

```bash
npx skills add caedes/agent-skills
```

There is no build step, no test suite, and no linter — this is a pure content repository (Markdown + shell scripts).

## Skill structure

Each skill lives in `skills/<skill-name>/` and requires exactly one `SKILL.md` file with YAML frontmatter:

```markdown
---
name: skill-name
description: >-
  Trigger description shown to the AI to determine when to activate this skill.
  Must be precise — this is how the agent decides whether to invoke the skill.
---

# Skill content...
```

Optional support files (scripts, templates, etc.) go in subdirectories of the skill folder (e.g., `skills/review-vs-branch/scripts/get-diff.sh`).

## Conventions across existing skills

- **Language**: skill prose is written in French; trigger descriptions in the `description` frontmatter are bilingual (FR + EN) to maximize cross-tool detection.
- **Output location**: skills that produce artifacts write them to `.cursor/` in the target project (e.g., `.cursor/research/`, `.cursor/plans/`).
- **File naming**: plan/research output files use `kebab-case-YYYY-MM-DD.md`.
- **Diagrams**: always Mermaid — never ASCII art or images.
- **Shell scripts**: use `#!/bin/bash`, default arguments via `${1:-default}`, and `git fetch origin` before any diff computation.

## Skill categories

| Category | Skills |
|---|---|
| Produit & Lead Tech | `research`, `structured-planning` |
| Développement & QA | `review-vs-branch` |

## Adding a new skill

1. Create `skills/<skill-name>/SKILL.md` with frontmatter (`name`, `description`) and the skill body.
2. Update the `## Skills disponibles` section in `README.md` with a one-line description.
3. Commit using Conventional Commits + gitmoji (e.g., `feat: ✏️ add my-skill`).
