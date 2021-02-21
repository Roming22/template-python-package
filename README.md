# Template project for a Python package

## How to use this project

### Prepare GitHub

- Create a new project on [github.com](https://github.com/).
- Open the repository `Settings`.
- Click on `Secrets`.
- Click on `New repository secret`
- Use `Name`: `TEST_PYPI_API_TOKEN`
- Create the test secret:
  - Go to [test.pypi.org](https://test.pypi.org/)
  - Register an account and login
  - Go to `Account settings`
  - Scroll down to `API tokens` and click on `Add API token`
  - Use `Token name`: `github`, `Scope`: `Entire account (all projects)`
  - Click on `Add token`
  - Copy the token
- Copy the token into `Value`
- Click `Add secret`
- Create an account on [pypi.org](https://pypi.org/) (the name can be the same as for `test.pypi.org`) and create a new token.
- Create a new secret, using `Name`: `PYPI_API_TOKEN`, and cpoy the token into  `Value`.

### Create a new package from this template project

- Follow the instructions in `CONTRIBUTING.md` to setup the project.
- Run `tools/init.sh`.
- Open your project on Github.
- Click on `Actions`.
- Check that the CI/CD workflow completed successfully.
- Check that you can see your package in PyPi.

## Architecture

### File system organization

- `src`: the source code of the application, and nothing more.
- `tools`: anything else that's required to make the project work but is not a part of the application. This may include source code, shell scripts, configuration files, etc...
- `tests`: holds tests that can be run with `pytest`.

### CI/CD

Whenever pull request is opened against the fork or a new changeset is pushed on the fork (including when a pull request is merged), the CI/CD will run. This is controlled by `.github/workflows/ci-cd.yml`. The content of the file is kept to a minimum, to keep it both readable and clean.

The CI will make sure that the project state is valid, and the CD will upload the corresponding package without any action from the user.

The version and the upload destination of the package depend on the action that triggered the CI/CD as well as the branch on which this action was triggered. All branches will upload to `test.pypi.org`, but `release/X.Y` branches will also upload to `pypi.org`.

### Versioning

Versioning for major and minor numbers is handled by creating `release/X.Y` branches. The patch number is automatically generated based on existing releases.

### Makefile

The project uses a `Makefile` as a way to provide quick access to common commands.