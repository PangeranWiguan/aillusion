@echo off
cd "C:\Godot-Projects\aillusion\llama.cpp"

:: Read the system prompt from the file
setlocal enabledelayedexpansion
set "system_prompt="
for /f "usebackq delims=" %%i in ("system_prompt.txt") do set "system_prompt=!system_prompt! %%i"

:: Escape special characters in the system prompt
set "escaped_system_prompt=%system_prompt:"=\"%"
set "escaped_system_prompt=%escaped_system_prompt:&=^&%"
set "escaped_system_prompt=%escaped_system_prompt:|=^|%"
set "escaped_system_prompt=%escaped_system_prompt:<=^<%"
set "escaped_system_prompt=%escaped_system_prompt:>=>>^>%"

:: Combine system prompt with user input
set "user_input=How are you today?"
set "full_prompt=%escaped_system_prompt% User: %user_input% Assistant:"

:: Run llama-cli.exe
echo Running AI with the following prompt:
echo %full_prompt%
llama-cli.exe -m models/qwen2.5-0.5b-instruct-q4_k_m.gguf -p "%full_prompt%" --temp 0.7 --top-p 0.9

pause