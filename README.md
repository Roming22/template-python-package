# Template project for a Python package

## How to use this project

### Prepare GitHub

- Fork the project on [github.com](https://github.com/).
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

### Create a new package

- Follow the instructions in `CONTRIBUTING.md` to setup the project, using your fork URL during the clone.
- Run `tools/rename.sh`.
- Run `poetry run pytest` again to validate that everything is working as designed.
- Push to your fork to check that the CI/CD is working OK.

## Architecture

### CI/CD

Whenever pull request is opened against the fork or a new changeset is pushed on the fork (including when a pull request is merged), the CI/CD will run.

The CI will make sure that the project state is valid, and the CD will upload the corresponding package.

The version and destination of the package depends on the action that triggered the CI/CD as well as the branch on which this action was triggered. All branches will upload to `test.pypi.org`, and `release/x.y` branches will also upload to `pypi.org`.
