@echo off
cd "C:\Godot-Projects\aillusion\llama.cpp"

:: Read the system prompt from the file
setlocal enabledelayedexpansion
set "system_prompt="
for /f "usebackq delims=" %%i in ("test_script/ai-chan_system_prompt.txt") do set "system_prompt=!system_prompt! %%i"

:: Escape special characters in the system prompt
set "escaped_system_prompt=%system_prompt:"=\"%"
set "escaped_system_prompt=%escaped_system_prompt:&=^&%"
set "escaped_system_prompt=%escaped_system_prompt:|=^|%"
set "escaped_system_prompt=%escaped_system_prompt:<=^<%"
set "escaped_system_prompt=%escaped_system_prompt:>=>>^>%"

:: Combine system prompt with AI's response initiation
set "full_prompt=%escaped_system_prompt% Assistant:"

:: Run llama-cli.exe
echo Running AI with the following prompt:
echo %full_prompt%
llama-cli.exe -m models/qwen2.5-3b-instruct-fp16-00001-of-00002.gguf -sys "%full_prompt%" -p "Hi" --temp 2.0 --top-p 0.9 -t 12 -co --keep -1 --log-file chat_log.txt --log-prefix --log-timestamps -c 100000 -s 1288850135

pause