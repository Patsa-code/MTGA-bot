
#NoEnv
#SingleInstance force
#NoTrayIcon
CoordMode, pixel, client
CoordMode, mouse, client
DetectHiddenWindows, on
SetTitleMatchMode, 3

if not winexist("Sparkly")
	ExitApp

iniread, sparklyhwnd, details.ini, main, sparklyhwnd
gui,turnloops:new,,turnloops

endpointer:=0
OnMessage(9001, "myturnloop")
OnMessage(9002, "opturnloop")
OnMessage(9000, "endmatch")
OnMessage(9003, "resetend")

return

turnloopsguiclose:
ExitApp
return

resetend()
{
	global endpointer
	endpointer:=0
}

endmatch()
{
	global endpointer
	endpointer:=1
}

opturnloop()
{
	
global endpointer, continuity, sparklyhwnd

IniRead, continuity, details.ini, main, continuity
continuity++
IniWrite, %continuity%, details.ini, main, continuity
IniWrite, 1, details.ini, main, playingatm
control, hide,, No active game, ahk_id %sparklyhwnd%
control, hide,, My turn, ahk_id %sparklyhwnd%
control, show,, Opponents turn, ahk_id %sparklyhwnd%
Loop
{
	if not winexist("Sparkly")
		ExitApp
	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, activenvar
	tempN:=tempn*5
	ImageSearch, , , 530, 582, 560, 586, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; my draw/1st main phase
	firstmain:=ErrorLevel
	WinActivate, MTGA
	ImageSearch, , , 720, 580, 725, 585, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; my 2nd main phase
	secondmain:=ErrorLevel
	If (firstmain = 0 or secondmain = 0)
	{
		myturnloop()
	}
	else
	{
		if (endpointer = 1)
			{
			endpointer:=0
			IniWrite, 0, details.ini, main, playingatm
			control, show,, No active game, ahk_id %sparklyhwnd%
			control, hide,, My turn, ahk_id %sparklyhwnd%
			control, hide,, Opponents turn, ahk_id %sparklyhwnd%
			Exit
			}
		IniRead, tempn, details.ini, n_var_for_tests, keepnvar
		tempN:=tempn*5
		ImageSearch, , , 715, 570, 805, 635, *%tempN% *TransBlack %A_WorkingDir%\images\keep.png
		If (ErrorLevel <> 0)
		{
			WinActivate, MTGA
			MouseMove 1090, 630
			Send {space down}
			Sleep 10
			Send {space up}
			sleep 100
		}
	}
}
}

myturnloop()
{
	
global endpointer, continuity, sparklyhwnd

IniRead, continuity, details.ini, main, continuity
continuity++
IniWrite, %continuity%, details.ini, main, continuity
IniWrite, 1, details.ini, main, playingatm
control, hide,, No active game, ahk_id %sparklyhwnd%
control, show,, My turn, ahk_id %sparklyhwnd%
control, hide,, Opponents turn, ahk_id %sparklyhwnd%
Loop ;PROLEM if it gives me a prompt durring draw phase and i need to interact with it
{
	if not winexist("Sparkly")
		ExitApp
	WinActivate, MTGA
	; check for concede here?
	IniRead, tempn, details.ini, n_var_for_tests, activenvar
	tempN:=tempn*5
	ImageSearch, , , 530, 582, 560, 586, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; my draw/1st main phase
	firstmain:=ErrorLevel
	ImageSearch, , , 720, 580, 725, 585, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; my 2nd main phase
	secondmain:=ErrorLevel
	If (firstmain = 0 or secondmain = 0)
		{
			if (endpointer = 1)
			{
				endpointer:=0
				IniWrite, 0, details.ini, main, playingatm
				control, show,, No active game, ahk_id %sparklyhwnd%
				control, hide,, My turn, ahk_id %sparklyhwnd%
				control, hide,, Opponents turn, ahk_id %sparklyhwnd%
				Exit
			}
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, nextnvar
			tempN:=tempn*5
			ImageSearch, stateposX, stateposY, 1155, 620, 1210, 650, *%tempN% *TransBlack %A_WorkingDir%\images\next.png
			nexttemp:=ErrorLevel
			ImageSearch, , , 1135, 620, 1235, 645, *%tempN% *TransBlack %A_WorkingDir%\images\endturn.png
			endturntemp:=ErrorLevel
			If (nexttemp = 0 or endturntemp = 0)
				{
					Sleep 250
					break
				}
		}
	if (endpointer = 1)
		{
			endpointer:=0
			IniWrite, 0, details.ini, main, playingatm
			control, show,, No active game, ahk_id %sparklyhwnd%
			control, hide,, My turn, ahk_id %sparklyhwnd%
			control, hide,, Opponents turn, ahk_id %sparklyhwnd%
			Exit
		}
}

spellsplayed:=0
landsplayed:=0
fullcycle:=0

Loop
{	
	
if not winexist("Sparkly")
	ExitApp
WinActivate, MTGA

MouseExpandX := 145
MouseExpandY := 710

IniRead, tempn, details.ini, n_var_for_tests, nextnvar
tempN:=tempn*5
ImageSearch, stateposX, stateposY, 1155, 620, 1210, 650, *%tempN% *TransBlack %A_WorkingDir%\images\next.png ;add 'end turn' image search?
If (ErrorLevel = 0 and fullcycle<2) ;waits til 'next' button image is found. if it is it scans for lands.
	{
		while (MouseExpandX<1100 and landsplayed<1) 	;land cycle
			{
				WinActivate, MTGA
				IniRead, tempn, details.ini, n_var_for_tests, activenvar
				tempN:=tempn*5
				ImageSearch, , , 548, 82, 573, 86, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; op draw or main1 phase
				if (ErrorLevel = 0)
					{
						opturnloop()
					}
				if (endpointer = 1)
					{
						endpointer:=0
						IniWrite, 0, details.ini, main, playingatm
						control, show,, No active game, ahk_id %sparklyhwnd%
						control, hide,, My turn, ahk_id %sparklyhwnd%
						control, hide,, Opponents turn, ahk_id %sparklyhwnd%
						Exit
					}
				WinActivate, MTGA
				MouseMove % MouseExpandX += 100, %MouseExpandY%
				;~ sleep 150
				IniRead, tempn, details.ini, n_var_for_tests, islandnvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\island.png
				islandcheck:=ErrorLevel
				IniRead, tempn, details.ini, n_var_for_tests, mountainnvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\mountain.png
				mountaincheck:=ErrorLevel
				IniRead, tempn, details.ini, n_var_for_tests, plainsnvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\plains.png
				plainscheck:=ErrorLevel
				IniRead, tempn, details.ini, n_var_for_tests, forestnvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\forest.png
				forestcheck:=ErrorLevel
				IniRead, tempn, details.ini, n_var_for_tests, swampnvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\swamp.png
				swampcheck:=ErrorLevel
				If (islandcheck = 0 or mountaincheck = 0 or plainscheck = 0 or forestcheck = 0 or swampcheck = 0)
					{
						if (endpointer = 1)
							{
								endpointer:=0
								IniWrite, 0, details.ini, main, playingatm
								control, show,, No active game, ahk_id %sparklyhwnd%
								control, hide,, My turn, ahk_id %sparklyhwnd%
								control, hide,, Opponents turn, ahk_id %sparklyhwnd%
								Exit
							}
						landsplayed++
						MouseClick
						Sleep 20
						MouseClick
						sleep 500
					}
			}
		WinActivate, MTGA
		landsplayed++
		MouseMove 1090, 630
		MouseClick
		MouseExpandX := 145
		MouseExpandY := 710
		while (MouseExpandX < 1100 and spellsplayed<3)	; Then it scans for castable spells
			{
				WinActivate, MTGA
				IniRead, tempn, details.ini, n_var_for_tests, activenvar
				tempN:=tempn*5
				ImageSearch, , , 548, 82, 573, 86, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; op draw or main1 phase
				if (ErrorLevel = 0)
					{
						opturnloop()
					}
				if (endpointer = 1)
					{
						endpointer:=0
						IniWrite, 0, details.ini, main, playingatm
						control, show,, No active game, ahk_id %sparklyhwnd%
						control, hide,, My turn, ahk_id %sparklyhwnd%
						control, hide,, Opponents turn, ahk_id %sparklyhwnd%
						Exit
					}
				WinActivate, MTGA
				MouseMove % MouseExpandX += 100, %MouseExpandY% ;move 100 pixels twowards the next card to expand it
				;~ Sleep, 150 ;wait for the card to expand
				IniRead, tempn, details.ini, n_var_for_tests, activenvar
				tempN:=tempn*5
				ImageSearch, , , % MouseExpandX -150, % MouseExpandY - 204, % MouseExpandX + 150, % MouseExpandY -204, *%tempN% %A_WorkingDir%\images\active.png 
				If (ErrorLevel = 0)
					{
						if (endpointer = 1)
							{
								endpointer:=0
								IniWrite, 0, details.ini, main, playingatm
								control, show,, No active game, ahk_id %sparklyhwnd%
								control, hide,, My turn, ahk_id %sparklyhwnd%
								control, hide,, Opponents turn, ahk_id %sparklyhwnd%
								Exit
							}
						WinActivate, MTGA
						spellsplayed++
						MouseClick
						Sleep 20
						MouseClick
						MouseMove 1090, 630
						MouseClick
						MouseExpandX := 145
						MouseExpandY := 710
					}	
			}
		fullcycle++
	}
Else
	{
		WinActivate, MTGA
		IniRead, tempn, details.ini, n_var_for_tests, activenvar
		tempN:=tempn*5
		ImageSearch, , , 548, 82, 573, 86, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; op draw or main1 phase
		if (ErrorLevel = 0)
			{
				opturnloop()
			}
		if (endpointer = 1)
			{
				endpointer:=0
				IniWrite, 0, details.ini, main, playingatm
				control, show,, No active game, ahk_id %sparklyhwnd%
				control, hide,, My turn, ahk_id %sparklyhwnd%
				control, hide,, Opponents turn, ahk_id %sparklyhwnd%
				Exit
			}
		; add 'keep' image search here to avoid weird mouse movements
		IniRead, tempn, details.ini, n_var_for_tests, keepnvar
		tempN:=tempn*5
		ImageSearch, , , 715, 570, 805, 635, *%tempN% *TransBlack %A_WorkingDir%\images\keep.png
		If (ErrorLevel <> 0)
		{
			WinActivate, MTGA
			MouseMove 1090, 630
			Send {space down}
			Sleep 10
			Send {space up}
			sleep 100
		}
		IniRead, tempn, details.ini, n_var_for_tests, timernvar
		tempN:=tempn*5
		ImageSearch, , , 110, 280, 165, 450, *%tempN% *TransBlack %A_WorkingDir%\images\timer.png
		timercon:=ErrorLevel
		IniRead, tempn, details.ini, n_var_for_tests, submitnvar
		tempN:=tempn*5
		ImageSearch, , , 1130, 620, 1235, 650, *%tempN% *TransBlack %A_WorkingDir%\images\submit.png
		subcon:=ErrorLevel
		IniRead, tempn, details.ini, n_var_for_tests, activenvar
		tempN:=tempn*5
		ImageSearch, , , 1000, 570, 1080, 630, *%tempN% *TransBlack %A_WorkingDir%\images\active.png
		planecon:=ErrorLevel
		IniRead, tempn, details.ini, n_var_for_tests, choicenvar
		tempN:=tempn*5
		ImageSearch, , , 420, 35, 860, 80, *%tempN% *TransBlack %A_WorkingDir%\images\choice.png
		choosecon:=ErrorLevel
		IniRead, tempn, details.ini, n_var_for_tests, costnvar
		tempN:=tempn*5
		ImageSearch, , , 990, 630, 1060, 660, *%tempN% *TransBlack %A_WorkingDir%\images\cost.png
		costcon:=ErrorLevel
		if (subcon = 0 or planecon = 0 or choosecon = 0 or costcon = 0 or timercon = 0)
			{
				Send {esc}
			}
		Sleep 500
		IniRead, tempn, details.ini, n_var_for_tests, activenvar
		tempN:=tempn*5
		ImageSearch, , , 548, 82, 573, 86, *%tempN% *TransBlack %A_WorkingDir%\images\phase.png ; op draw or main1 phase
		if (ErrorLevel = 0)
		{
			opturnloop()
		}
	}
}
}
