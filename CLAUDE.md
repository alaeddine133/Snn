# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project

`snn` — new project, no code yet. Planned: payments with Stripe.

Update this file as the project takes shape (stack, how to run, how to test).

## Conventions

- Keep changes small and focused; explain the "why" in commit messages.
- Never commit secrets. Stripe keys go in environment variables (`STRIPE_SECRET_KEY`,
  `STRIPE_PUBLISHABLE_KEY`, `STRIPE_WEBHOOK_SECRET`), never in code.
- Use Stripe test mode keys (`sk_test_...`) during development.

## Commands

_Fill in once the project exists:_

- Install: `...`
- Run: `...`
- Test: `...`
