#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetKeyDelay 30,50
`::
loop
{
    if (run) break
    clipboard := ""
    Send {CTRL DOWN}c{CTRL UP}
    ClipWait 
    Sleep, 200
    Send {ALT DOWN}{TAB}{ALT UP}
    Sleep, 200 
    Send {DOWN}{END},
    Sleep, 200 
    Send {CTRL DOWN}v{CTRL UP}
    Sleep, 200 
    Send {ALT DOWN}{TAB}{ALT UP}
    Sleep, 200 
    Send {DOWN}
    Sleep, 200 
}
return