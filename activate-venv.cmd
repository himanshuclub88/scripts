@echo off

powershell -NoProfile -Command "Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force"

powershell -NoProfile -ExecutionPolicy Bypass -File "C:\venvs\scripts\activate-venv.ps1" %*