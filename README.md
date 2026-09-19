# create-setup

A lightweight Windows PowerShell utility for quickly creating and managing Python virtual environments outside your project directory.

The goal is simple:

```powershell
create-setup .venv requirements.txt
```

Instead of manually running several commands for every Python project, this utility creates the virtual environment, upgrades `pip`, and installs the project's dependencies from a requirements file.

---

## Features

- Create Python virtual environments with one command
- Keep virtual environments outside the project directory
- Automatically use the current directory name as the project name
- Support multiple virtual environments for the same project
- Support different requirements files
- Available globally from any PowerShell directory
- Simple Windows/PowerShell setup
- No Python package installation required for the utility itself

---

# 1. How It Works

Suppose your project is:

```text
C:\Projects\my-ai-app
```

Run:

```powershell
create-setup .venv requirements.txt
```

The utility creates:

```text
C:\venvs\my-ai-app\.venv
```

and installs the dependencies from:

```text
C:\Projects\my-ai-app\requirements.txt
```

The project name is automatically taken from the current directory.

The general structure is:

```text
Current project directory
        │
        ├── requirements.txt
        │
        └── source code
        │
        ▼
C:\venvs\<project-name>\<venv-name>
```

This keeps the virtual environment separate from the source-code directory.

---

# 2. Basic Usage

Go to a Python project:

```powershell
cd C:\Projects\my-ai-app
```

Run:

```powershell
create-setup .venv requirements.txt
```

Result:

```text
C:\venvs\my-ai-app\.venv
```

The command performs these operations:

```text
1. Detect current project name
2. Create the virtual environment
3. Upgrade pip
4. Install packages from requirements.txt
```

---

# 3. Command Syntax

```powershell
create-setup <venv-name> <requirements-file>
```

### Example

```powershell
create-setup .venv requirements.txt
```

### Another example

```powershell
create-setup .venv1 requirements2.txt
```

For a project called `my-ai-app`, this creates:

```text
C:\venvs\my-ai-app\.venv1
```

and installs:

```text
requirements2.txt
```

---

# 4. Multiple Environments

You can create multiple environments for the same project.

Example:

```powershell
create-setup .venv requirements.txt
create-setup .venv-dev requirements-dev.txt
create-setup .venv-test requirements-test.txt
```

Result:

```text
C:\venvs\
└── my-ai-app\
    ├── .venv\
    ├── .venv-dev\
    └── .venv-test\
```

This can be useful when a project has different dependency sets for development, testing, experimentation, or other purposes.

---

# 5. Requirements Files

The second argument can be any requirements file that exists in the current project directory.

For example:

```powershell
create-setup .venv requirements.txt
```

or:

```powershell
create-setup .venv-dev requirements-dev.txt
```

or:

```powershell
create-setup .venv-test requirements-test.txt
```

The file is passed directly to:

```powershell
pip install -r <requirements-file>
```

---

# 6. Prerequisites

Before using the utility, install Python.

Verify Python:

```powershell
python --version
```

Example:

```text
Python 3.11.x
```

Verify pip:

```powershell
python -m pip --version
```

Verify PowerShell:

```powershell
$PSVersionTable.PSVersion
```

Git is only required if you want to clone this repository from GitHub.

Verify Git:

```powershell
git --version
```

---

# 7. Installation

## Option A — Clone the Repository

Clone the repository:

```powershell
git clone https://github.com/himanshuclub88/scripts.git
```

Enter the repository:

```powershell
cd scripts
```

The repository contains the utility files:

```text
create-setup.ps1
create-setup.cmd
README.md
```

For the current implementation, place the utility files in:

```text
C:\venvs\scripts\
```

so that the resulting structure is:

```text
C:\venvs\
└── scripts\
    ├── create-setup.ps1
    ├── create-setup.cmd
    └── README.md
```

---

# 8. Add the Utility to Windows PATH

Adding the scripts directory to PATH allows this:

```powershell
create-setup .venv requirements.txt
```

to work from any directory.

### Using the Windows GUI

1. Open Windows Search.
2. Search for:
   `Environment Variables`
3. Select:
   `Edit the system environment variables`.
4. Click:
   `Environment Variables...`
5. Under **User variables**, select `Path`.
6. Click **Edit**.
7. Click **New**.
8. Add:

```text
C:\venvs\scripts
```

9. Click **OK** on all dialogs.
10. Close PowerShell.
11. Open a new PowerShell window.

---

# 9. Add PATH Using PowerShell

You can also add the directory to the user's PATH from PowerShell.

First inspect the existing user PATH:

```powershell
[Environment]::GetEnvironmentVariable("Path", "User")
```

To add the directory:

```powershell
$path = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = $path + ";C:\venvs\scripts"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
```

Close PowerShell and open a new PowerShell window after changing PATH.

> Avoid repeatedly running the command above because it can add duplicate PATH entries.

---

# 10. Verify the Installation

Open a **new** PowerShell window.

Check that the directory is in PATH:

```powershell
$env:Path -split ';'
```

Look for:

```text
C:\venvs\scripts
```

Then check that Windows can find the command:

```powershell
where.exe create-setup
```

Expected result:

```text
C:\venvs\scripts\create-setup.cmd
```

If this command returns the path to `create-setup.cmd`, the global command is available.

---

# 11. First Test

Create or open a test Python project:

```powershell
mkdir C:\Projects\test-python-project
cd C:\Projects\test-python-project
```

Create a requirements file:

```powershell
"requests" | Set-Content requirements.txt
```

Run:

```powershell
create-setup .venv requirements.txt
```

The utility should create:

```text
C:\venvs\test-python-project\.venv
```

and install `requests`.

---

# 12. Activating the Environment

The utility creates the environment and installs the dependencies.

To activate the environment in your current PowerShell session, run:

```powershell
C:\venvs\<project-name>\.venv\Scripts\Activate.ps1
```

For example:

```powershell
C:\venvs\test-python-project\.venv\Scripts\Activate.ps1
```

After activation, PowerShell normally displays the environment name:

```text
(.venv) PS C:\Projects\test-python-project>
```

You can then run:

```powershell
python --version
```

and:

```powershell
pip list
```

---

# 13. Why Keep the Virtual Environment Outside the Project?

A Python virtual environment can contain many files.

Keeping it outside the source directory can be useful when:

- the project is stored in Google Drive or another synchronized folder
- the project is stored in Git
- you frequently recreate environments
- you want to avoid accidentally committing `.venv`
- you want a central location for local Python environments

For example:

```text
Project:
C:\Projects\my-ai-app

Environment:
C:\venvs\my-ai-app\.venv
```

The source repository remains smaller and cleaner.

---

# 14. Recreating an Environment

If an environment becomes corrupted, delete it and recreate it.

For example:

```powershell
Remove-Item -Recurse -Force C:\venvs\my-ai-app\.venv
```

Then go back to the project:

```powershell
cd C:\Projects\my-ai-app
```

Run:

```powershell
create-setup .venv requirements.txt
```

The environment will be recreated from the requirements file.

---

# 15. Recovery After Windows Reinstallation

The utility is designed to be easy to restore.

Keep a copy of this repository somewhere outside the computer, such as:

- GitHub
- another computer
- external storage
- cloud storage

After reinstalling Windows:

### Step 1 — Install Python

```powershell
python --version
```

### Step 2 — Restore the utility

Restore:

```text
C:\venvs\scripts\
```

with:

```text
create-setup.ps1
create-setup.cmd
README.md
```

### Step 3 — Add the scripts directory to PATH

Add:

```text
C:\venvs\scripts
```

to the User PATH.

### Step 4 — Open a new PowerShell

Verify:

```powershell
where.exe create-setup
```

Expected:

```text
C:\venvs\scripts\create-setup.cmd
```

### Step 5 — Restore a project environment

Go to the project:

```powershell
cd C:\Projects\my-ai-app
```

Run:

```powershell
create-setup .venv requirements.txt
```

The environment is recreated from the project's dependency file.

---

# 16. What Should Be Stored in Git?

Recommended repository structure:

```text
create-setup/
│
├── create-setup.ps1
├── create-setup.cmd
├── README.md
└── LICENSE
```

Do **not** commit generated virtual environments:

```text
.venv/
venv/
env/
```

Also do not commit:

```text
.env
*.key
*.pem
credentials.json
service-account.json
```

or other files containing passwords, API keys, tokens, private keys, or credentials.

---

# 17. Troubleshooting

## `create-setup` is not recognized

Run:

```powershell
where.exe create-setup
```

If nothing is returned, check that:

```text
C:\venvs\scripts
```

is in PATH.

Then close PowerShell and open a new PowerShell window.

---

## `where.exe create-setup` returns nothing

Check that the command file exists:

```powershell
Test-Path C:\venvs\scripts\create-setup.cmd
```

It should return:

```text
True
```

If it returns `False`, verify the file location.

---

## Python is not recognized

Run:

```powershell
python --version
```

If Python is not found, install Python and ensure the Python executable is available through PATH.

---

## `requirements.txt` cannot be found

Make sure you are inside the project directory:

```powershell
Get-Location
```

Then check:

```powershell
Get-ChildItem requirements*.txt
```

Run the command using the correct requirements filename.

---

# 18. Quick Reference

### Create default environment

```powershell
create-setup .venv requirements.txt
```

### Create another environment

```powershell
create-setup .venv1 requirements2.txt
```

### Check command location

```powershell
where.exe create-setup
```

### Check Python

```powershell
python --version
```

### Check pip

```powershell
python -m pip --version
```

### Check current directory

```powershell
Get-Location
```

### Activate an environment

```powershell
C:\venvs\<project-name>\.venv\Scripts\Activate.ps1
```

### Deactivate

```powershell
deactivate
```

---

# License

Add the project's chosen open-source license here.

For example, this project can use the MIT License if that is the license selected by the repository owner.
