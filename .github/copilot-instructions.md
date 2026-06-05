# Copilot Instructions for BonkeyWonkers

## Project Overview

BonkeyWonkers is a multi-exercise repository designed to test and teach
infrastructure automation skills. It covers Terraform, Docker, scripting,
Grafana, Vault, GitHub Actions, Ansible, and Kubernetes. Each `exerciseN/`
folder is a self-contained scenario with its own README and supporting files.

## Architecture & Structure

- **Exercises:** Each `exerciseN/` directory focuses on a specific technology
  or workflow. Read the local `README.md` for context and requirements.
- **Modules:** Shared Terraform modules are in `modules/`. Exercise-specific
  modules may exist in subfolders.
- **Roles:** Ansible roles are under `roles/`, with templates and variable
  files for configuration.
- **Key Files:**
  - `main.tf`, `providers.tf` (Terraform)
  - `docker-compose.yaml`, `Dockerfile` (Docker)
  - `helloworld.py` (Python scripting)
  - `BonkeyContainers.yaml` (container definitions)
  - `bonkey_playbook.yaml` (Ansible playbook)

## Developer Workflows

- Run in exercise folders with `main.tf` and `providers.tf`.
- Use modules from `modules/` as needed.
- Templating: Some modules use `.tftpl` files for dynamic content.
- Build images using `Dockerfile` and `docker-compose.yaml`.
- Container definitions may be in `BonkeyContainers.yaml`.
- Workflows are created/updated in `.github/` (e.g., `Bonkey-Check.yaml`).
- Use [act](https://github.com/nektos/act) to test workflows locally.
- Pass variables between jobs as described in exercise READMEs.

All merge commits must pass the pre-commit checks before merging to the main
branch. This is enforced by a GitHub Actions workflow (see badge and workflow
in the main `README.md`).

**How to validate pre-commit locally:**

- Run the pre-commit hooks manually before pushing changes.
- Ensure all files meet linting, formatting, and other repository-specific
  requirements.
- If a merge commit fails pre-commit, it must be fixed before merging.

Refer to the main `README.md` for details on the workflow and troubleshooting
failed checks.

- **Ansible:**
- Playbooks and roles are in `exercise10/` and `roles/`.
- Templates use Jinja2 syntax (see `Dockerfile.j2`).
- **Kubernetes:**
  - Manifests and deployment scripts are in `exercise11/`.
  - Use `kubectl` for cluster operations and testing.
  - Follow the exercise README for deployment, scaling, and management tasks.

## Patterns & Conventions

- **Exercise Isolation:** Each exercise is independent; do not cross-reference
  files unless instructed.
- **File Naming:** Follow the naming in each exercise (e.g.,
  `BonkeyContainers.yaml`, `main.tf`).
- **Workflow Testing:** Use `act` for local workflow validation before pushing.
- **Versioning:** For FRR and other dependencies, reference the major version
  in container files as described in exercise instructions.

## Integration Points

- **External APIs:** Some workflows fetch data from external sources (e.g.,
  FRR releases via GitHub API).
- **Cross-Component Communication:** Pass variables between workflow jobs as
  shown in exercises 8 and 9.

## Example: Creating a Workflow

- Place workflow YAML in `.github/` (e.g., `Bonkey-Check.yaml`).
- Use job outputs to pass data between jobs.
- Reference container versions from `BonkeyContainers.yaml`.

## References

- Main project README: [`README.md`](../README.md)
- Exercise-specific instructions: `exerciseN/README.md`
- Ansible role templates: `roles/bonkey/templates/`
- Terraform modules: `modules/`

---
_Review exercise READMEs for specific requirements and patterns. Update this
file as new conventions emerge._
