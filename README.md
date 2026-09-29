# ⚡ create-setup

### Fast Python Virtual Environments for Shared-Drive Projects

`create-setup` is a lightweight Windows utility for creating and activating Python virtual environments without storing the environment inside your project directory.

It is especially useful when your Python projects are stored on a **network/shared drive**.

---

# 🤔 Why Do We Need This?

Creating a Python virtual environment is normally very easy:

```powershell
python -m venv .venv
```

So why use another utility?

The problem is **where the virtual environment is created**.

A Python virtual environment is not just one file. It contains a large number of files and directories.

For example:

```text
.venv\
├── Scripts\
├── Lib\
│   └── site-packages\
│       ├── package1\
│       ├── package2\
│       ├── package3\
│       └── ...
└── ...
```

When the project is located on a **local SSD**, this usually isn't a problem.

But when the project is located on a **network/shared drive**, creating or extracting a virtual environment can become extremely slow.

---

## 🐌 The Shared-Drive Problem

Imagine a shared drive that is being used by **30+ people**.

Downloading a file from the shared drive might be reasonably fast.

But extracting/unzipping a Python environment is different.

The extraction process may need to create **thousands of individual files and directories** over the network.

So instead of:

```text
Download one large file
        ↓
Fast
```

you effectively get:

```text
Create file
   ↓
Network request
   ↓
Create another file
   ↓
Network request
   ↓
Create another file
   ↓
Network request
   ↓
... thousands of times
```

On a busy shared/network drive, this can become extremely slow.

In some environments, creating/extracting a Python virtual environment can take **30–40 minutes or more**.

---

# 💡 The Solution

The idea behind `create-setup` is simple:

> **Keep your project wherever you want, but keep the Python environment on the local machine.**

For example, your project may be on a shared drive:

```text
Shared Drive
│
└── Projects
    └── my-ai-project
        ├── main.py
        ├── requirements.txt
        └── ...
```

Instead of creating:

```text
Shared Drive
│
└── Projects
    └── my-ai-project
        └── .venv      ← ❌ thousands of files on network
```

`create-setup` creates the environment locally:

```text
Shared Drive
│
└── Projects
    └── my-ai-project
        ├── main.py
        ├── requirements.txt
        └── ...


Local Machine
│
└── C:\venvs
    └── my-ai-project
        └── .venv      ← ✅ local
```

This means the source code can remain on the shared drive while the virtual environment is created on the local machine.

---

# 🚀 Only Two Commands

The whole workflow is built around two commands:

```text
create-setup
```

and:

```text
activate-venv
```

Both commands work from:

* ✅ Command Prompt (CMD)
* ✅ PowerShell

---

# 1️⃣ `create-setup`

Use this command when you want to **create a Python environment for a project**.

Go to your project:

```cmd
cd X:\Shared\Projects\my-ai-project
```

Then run:

```cmd
create-setup
```

The utility automatically:

```text
1. Detects the project name
2. Creates the environment locally
3. Creates the Python virtual environment
4. Upgrades pip
5. Installs packages from requirements.txt
```

For example:

```text
Project:

X:\Shared\Projects\my-ai-project


        create-setup
              │
              ▼


Local environment:

C:\venvs\my-ai-project\.venv
```

Your project remains on the shared drive.

The heavy virtual-environment files stay on the local machine.

---

# 2️⃣ `activate-venv`

Once the environment has been created, use:

```cmd
activate-venv
```

The utility finds the environment belonging to the current project and activates it.

For example:

```cmd
cd X:\Shared\Projects\my-ai-project
activate-venv
```

You should then see something similar to:

```text
(.venv) X:\Shared\Projects\my-ai-project>
```

Now you can work normally:

```cmd
python main.py
```

or:

```cmd
pip list
```

---

# 🔄 Daily Workflow

You only need to create the environment once.

### First time

```cmd
cd X:\Shared\Projects\my-ai-project

create-setup

activate-venv
```

### Every day after that

```cmd
cd X:\Shared\Projects\my-ai-project

activate-venv
```

You **do not need to run `create-setup` every time**.

---

# 📦 Installation

You only need to configure the utility **once**.

## Step 1 — Install Python

Make sure Python is installed:

```cmd
python --version
```

Example:

```text
Python 3.11.x
```

---

## Step 2 — Get the Utility

Clone the repository:

```cmd
cd C:\
mkdir venvs
cd venvs

git clone https://github.com/himanshuclub88/scripts.git
```

The utility should be available under:

```text
C:\venvs\scripts
```

The important files are:

```text
C:\venvs\scripts\
├── create-setup.cmd
├── create-setup.ps1
├── activate-venv.cmd
├── activate-venv.ps1
└── README.md
```

> The `.cmd` and `.ps1` files are implementation details. As a user, you only need to remember `create-setup` and `activate-venv`.

---

# 🔧 Step 3 — Add to PATH

To use the commands from any project directory, add:

```text
C:\venvs\scripts
```

to your Windows **User PATH**.

### Windows

1. Open **Windows Search**
2. Search for **Environment Variables**
3. Open **Edit the system environment variables**
4. Click **Environment Variables**
5. Under **User variables**, select `Path`
6. Click **Edit**
7. Click **New**
8. Add:

```text
C:\venvs\scripts
```

9. Click **OK**
10. Close your CMD/PowerShell window
11. Open a new CMD/PowerShell window

---

# 🔍 Step 4 — Verify

Run:

```cmd
where create-setup
```

You should see:

```text
C:\venvs\scripts\create-setup.cmd
```

Then:

```cmd
where activate-venv
```

You should see:

```text
C:\venvs\scripts\activate-venv.cmd
```

If both commands return a path, you're ready to go.

---

# 🐍 Example: Shared Drive Project

Suppose your company project is located here:

```text
\\SharedDrive\Projects\DataEngineering\customer-project
```

Go to the project:

```cmd
cd \\SharedDrive\Projects\DataEngineering\customer-project
```

Your project contains:

```text
customer-project\
├── src\
├── main.py
├── requirements.txt
└── ...
```

Run:

```cmd
create-setup
```

The utility creates the environment locally:

```text
C:\venvs\
└── customer-project\
    └── .venv
```

The dependencies are installed locally.

Your source code stays on the shared drive.

Then activate:

```cmd
activate-venv
```

Now you can work with the project normally.

---

# 🔀 Multiple Environments

You can create multiple environments for the same project.

For example:

```cmd
create-setup .venv-dev requirements-dev.txt
```

and:

```cmd
create-setup .venv-test requirements-test.txt
```

This can result in:

```text
C:\venvs\
└── customer-project\
    ├── .venv
    ├── .venv-dev
    └── .venv-test
```

When you run:

```cmd
activate-venv
```

the utility can detect the available environments and let you choose the one you want.

---

# 📝 Custom Requirements

The default command:

```cmd
create-setup
```

uses:

```text
.venv
requirements.txt
```

You can specify both:

```cmd
create-setup .venv-dev requirements-dev.txt
```

For example:

```text
my-project\
├── requirements.txt
├── requirements-dev.txt
├── requirements-test.txt
└── main.py
```

You can create separate environments for different dependency sets.

---

# 📁 Where Does the Environment Go?

The project name is detected automatically from the current directory.

For:

```text
X:\Shared\Projects\my-ai-project
```

the environment is stored at:

```text
C:\venvs\my-ai-project\.venv
```

The general structure is:

```text
<Project Location>
        │
        │
        ▼
my-ai-project
├── source code
├── requirements.txt
└── ...


        +
        │
        │ create-setup
        ▼


C:\venvs\
└── my-ai-project\
    └── .venv
```

---

# ⚡ Quick Reference

| Task                      | Command                                       |
| ------------------------- | --------------------------------------------- |
| Create environment        | `create-setup`                                |
| Activate environment      | `activate-venv`                               |
| Create custom environment | `create-setup .venv-dev`                      |
| Use custom requirements   | `create-setup .venv-dev requirements-dev.txt` |
| Find create command       | `where create-setup`                          |
| Find activate command     | `where activate-venv`                         |
| Check Python              | `python --version`                            |
| Deactivate                | `deactivate`                                  |

---

# 🎯 In One Example

If your project is on a shared drive:

```cmd
cd X:\Shared\Projects\my-project
```

Create the environment:

```cmd
create-setup
```

Activate it:

```cmd
activate-venv
```

That's the entire workflow.

```text
        SHARED DRIVE
             │
             │  Source Code
             ▼
      ┌───────────────┐
      │  my-project   │
      │               │
      │ main.py       │
      │ requirements  │
      └───────┬───────┘
              │
              │ create-setup
              ▼
       LOCAL MACHINE
      ┌───────────────┐
      │   C:\venvs    │
      │               │
      │ my-project    │
      │    └─ .venv   │
      └───────────────┘
              │
              │ activate-venv
              ▼
          👨‍💻 CODE
```

### The main idea

**Your code can live on the shared drive.
Your Python environment stays local.**

That avoids the unnecessary overhead of creating thousands of virtual-environment files across a busy network/shared drive.

---

# 🚀 Two Commands. One Simple Workflow.

```cmd
create-setup
```

**Create the environment.**

```cmd
activate-venv
```

**Start using the environment.**

That's it.
