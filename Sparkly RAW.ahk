 
#NoEnv
#NoTrayIcon
#SingleInstance, ignore
CoordMode, pixel, client
CoordMode, mouse, client
DetectHiddenWindows, on
SetTitleMatchMode, 3

continuity:=0
continuitymark:=0
resettime := 0
resetstarted := 0
Adjreset := 0
timerrunning:=0
AdjTime:=0
victorycounter:=0
losscounter:=0
IniWrite, 0, details.ini, main, playingatm
IniWrite, %continuity%, details.ini, main, continuity

gui, main:margin, 10, 10

gui, main:add, Button, Section w126 ginstructions, Instructions
gui, main:add, Button, ys w126, Image troubleshoot
gui, main:add, button, xs section w126 gchangeplayhotkey vchangeplayhk,Play/pause hotkey
gui, main:add, button, ys w126 gchangeexithotkey vchangeexithk, Exit hotkey
gui, main:add, text, xs+1 y+22 w263 0x10

gui, main:add, Button, xs y+10 w50 h40 vfilepath -E0x0200 section, MTGA path 
gui, main:add, edit, ys w201 h40 vfiletext ReadOnly

gui, main:add, DropDownList, section xs+1 w48 vWins#_ddl gsubmit_ddl, 1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
gui, main:add, text, ys+4, How many wins will the script go for?

gui, main:add, DropDownList, section xs+1 vending_ddl gsubmit_ddl AltSubmit, Pause script|Close script|Close script & MTGA|Turn off PC
gui, main:add, text, ys+4, Once wins are achieved?

gui, main:add, checkbox, xs+18 vcheckb0 gsubmit_checkb section
gui, main:add, text, ys w220, Is "remember me" checked, on the login screen?
gui, main:add, checkbox, xs vcheckb1 gsubmit_checkb section
gui, main:add, text, ys, Is resolution set to 1280 x720?
gui, main:add, checkbox, xs vcheckb2 gsubmit_checkb section
gui, main:add, text, ys, Is the client in windowed mode? 
gui, main:add, checkbox, xs vcheckb3 gsubmit_checkb section
gui, main:add, text, ys, Have you selected a viable bot deck?
gui, main:add, checkbox, xs vcheckb4 gsubmit_checkb section
gui, main:add, text, ys, Is the play button visible at the bottom right?


gui, main:add, button, h50 w142 y+20 xm vrunbutton hwndrunbuttonhwnd gpause_script section +Disabled 
gui, main:add, button, h50 w142 xp yp vpausebutton hwndpausebuttonhwnd gpause_script +Disabled
gui, main:add, button, h50 w142 xp yp vcontinuebutton hwndcontinuebuttonhwnd gpause_script +Disabled
gui, main:add, button, h50 w110 ys vexitbutton gpress_exit

gui, main:add, text, xs+1 y+25 w263 0x10

gui, main:add, groupbox, xs y+10  w260 h33 section, Status
gui, main:font, s14 cGray
gui, main:add, text, w250  Center xp+5 yp+5 +BackgroundTrans hidden,  Hasn't begun
gui, main:font
gui, main:font, s14 cLime
gui, main:add, text, w250  Center xp yp +BackgroundTrans,  Running
gui, main:font
gui, main:font, s14 cRed
gui, main:add, text, w250  Center xp yp +BackgroundTrans,  Paused
gui, main:font
gui, main:add, groupbox, xs ys+25  w260 h33 section
gui, main:font, s12 cFuchsia
gui, main:add, text, w250  Center xp+5 yp+8 +BackgroundTrans hidden,  No active game
gui, main:add, text, w250  Center xp yp +BackgroundTrans,  My turn
gui, main:add, text, w250  Center xp yp +BackgroundTrans,  Opponents turn
gui, main:font
gui, main:add, groupbox, xs ys+25  w260 h33 section
gui, main:font, s12
gui, main:add, text, w250  Center xp+5 yp+10 +BackgroundTrans vstopwatch, Time: 00:00:00
gui, main:font
gui, main:add, groupbox, section xs yp+15 w130 h30
gui, main:font, s12
gui, main:add, text, w130 xs ys+8 +BackgroundTrans center, Wins
gui, main:font
gui, main:add, groupbox, ys xs+129 w131 h30
gui, main:font, s12
gui, main:add, text, w130 xs+130 ys+8 +BackgroundTrans center, Loses
gui, main:font
gui, main:add, groupbox, section xs ys+22 w130 h30
gui, main:font, s12
gui, main:add, text, w130 xs ys+8 +BackgroundTrans center vwincounter
gui, main:font
gui, main:add, groupbox, ys x+-1 w131 h30
gui, main:font, s12
gui, main:add, text, w130 xs+130 ys+8 +BackgroundTrans center vlosscounter, %losscounter%
gui, main:font

gui, images:new, +hwndimageswindowhwnd, Image Troubleshoot
gui, images:margin, 2, 2

gui, images:add, button, w100 y+10 gtestinstructions, How it works
gui, images:add, button, w100 x+288 gRestoredefaults,  Restore defaults


names := []
namesline1 := ["play", "island", "DCed"]
namesline2 := ["keep", "forest", "submit"]
namesline3 := ["next", "mountain", "active"]
namesline4 := ["prize", "plains", "choice"]
namesline5 := ["draw", "swamp", "cost"]
namesline6 := ["victory", "first", "concede"]
namesline7 := ["defeat", "second", "timer"]
namesline8 := ["endturn"]

Loop 8
	{
		names[a_index] := namesline%a_index%
		temp1:=names[a_index][1]"nvar"
		temp2:=names[a_index][2]"nvar"
		temp3:=names[a_index][3]"nvar"
		IniRead, %temp1%, details.ini, n_var_for_tests, %temp1%
		IniRead, %temp2%, details.ini, n_var_for_tests, %temp2%
		IniRead, %temp3%, details.ini, n_var_for_tests, %temp3%
	}

for index, array in names
	for i, word in array
		{
			gui, images:font, s12
			if (i=1)
				gui, images:add, button, % (index=1 ? "xs y+10 " : "xs y+1 ") "w75 h23 center section gimagetestpreview", % names[index][i]
			else
				gui, images:add, button, w75 h23 x+10 ys center gimagetestpreview, % names[index][i]
			gui, images:font
			temp1:=names[index][i]
			temp2:= %temp1%nvar
			gui, images:add, DropDownList, % "ys+1 w37 altsubmit gtestimagenvar choose" temp2 " v" names[index][i] "_ddlnvar", 5|10|15|20|25|30|35|40|45|50|55|60|65|70|75|80|85|90
			gui, images:add, button, % "ys x+2 w40 h23 gbuttontest v" names[index][i] " hwnd" names[index][i] "hwnd", Test
		}

gui, images:add, text, xs+10 y+10 w100 section, ----previews----

for index, array in names
		for i, k in array
			{
				if (index=1 and i=1)
					gui, images:add, picture, ys+26 xp hidden v%k%image, %A_WorkingDir%\images\%k%.bmp
				else if (index=3 and i=3)
					gui, images:add, picture, ys+26 xp h50 w-1 hidden v%k%image, %A_WorkingDir%\images\%k%.bmp
				else
					gui, images:add, picture, ys+26 xp hidden v%k%image, %A_WorkingDir%\images\%k%.bmp
			}

gui, images:add, picture, ys+26 xp  vinstructionsimage hidden, %A_WorkingDir%\images\instructions1.png

gui, testinstructions:new
gui, testinstructions:add, picture, , %A_WorkingDir%\images\instructions1.png

gui, instructions:new
gui, instructions:add, picture, , %A_WorkingDir%\images\instructions3.png

gui, pause: new
gui, pause:+ownermain
gui, pause: -MinimizeBox
gui, pause: font, s10
gui, pause: add, text,center w150, Play/pause hotkey
gui, pause: font
gui, pause: add, hotkey, w150 y+15 vpause_hk
gui, pause: add, button,y+15 section h30 w70 default, submit
gui, pause: add, button,ys x+10  h30 w70, cancel

gui, exit: new
gui, exit:+ownermain
gui, exit: -MinimizeBox
gui, exit: font, s10
gui, exit: add, text,center w150, Exit hotkey
gui, exit: font
gui, exit: add, hotkey, w150 y+15 vexit_hk
gui, exit: add, button,y+15 section h30 w70 default, submit
gui, exit: add, button,ys x+10  h30 w70, cancel

GuiControl, main:hide, pausebutton
GuiControl, main:hide, continuebutton
GuiControl, main:hide, Paused
GuiControl, main:hide, Running
GuiControl, main:hide, My turn
GuiControl, main:hide, Opponents turn

iniread, FolderText, details.ini, main, Mtga_Path
if (FolderText = "")
	{
		GuiControl, main:text, filetext, Please select the Mtga exe file
	}
else
	{
		GuiControl, main:text, filetext, %FolderText%
	}
	
IniRead, ending_ddl, details.ini, main, Endaction
IniRead, Wins#_ddl, details.ini, main, Wins
GuiControl, main:choose, ending_ddl, %ending_ddl%
GuiControl, main:choose, Wins#_ddl, %Wins#_ddl%
GuiControl,main:, wincounter, %victorycounter%/%Wins#_ddl%

IniRead, pausehktext, details.ini, main, pauseHK
pausehkerror:=0
try hotkey, %pausehktext%, pause_script
catch
	{
		pausehkerror:=1
		GuiControl, main:text, runbutton, Run`n(hotkey: Not set)
		GuiControl, main:text, pausebutton, Pause`n(hotkey: Not set)
		GuiControl, main:text, continuebutton, Continue`n(hotkey: Not set)
	}
if (pausehkerror = 0)
	{
		finalpausehotkey:=strreplace(pausehktext, "+", "Shift+")
		finalpausehotkey:=strreplace(finalpausehotkey,"!","Alt+") 
		finalpausehotkey:=strreplace(finalpausehotkey,"^","Ctrl+")
		GuiControl, main:text, runbutton, Run`n(hotkey: %finalpausehotkey%)
		GuiControl, main:text, pausebutton, Pause`n(hotkey: %finalpausehotkey%)
		GuiControl, main:text, continuebutton, Continue`n(hotkey: %finalpausehotkey%)
	}

IniRead, exithktext, details.ini, main, exitHK
exithkerror:=0
try hotkey, %exithktext%, exit_script
catch
	{
		exithkerror:=1
		GuiControl, main:text, exitbutton, Exit`n(hotkey: Not set)
	}
if (exithkerror = 0)
	{
		finalexithotkey:=strreplace(exithktext, "+", "Shift+")
		finalexithotkey:=strreplace(finalexithotkey,"!","Alt+") 
		finalexithotkey:=strreplace(finalexithotkey,"^","Ctrl+")
		GuiControl, main:text, exitbutton, Exit`n(hotkey: %finalexithotkey%)
	}
	
gui, main:+hwndsparklyhwnd
IniWrite, %sparklyhwnd%, details.ini, main, sparklyhwnd
gui, main:show, autosize, Sparkly

OnMessage(0x200, "checkruntooltip")

return

Restoredefaults:
MsgBox , 270339, Warning, Are you sure you want to restore the tolerance`nvariables to their default value?
IfMsgBox yes
	{
		for index, array in names
		for i, word in array
			{
				IniRead, temp1, defaults.ini, main, % word . "nvar"
				GuiControl, images:choose, % word . "_ddlnvar", |%temp1%
			}
	}
return

testimagenvar:
gui, submit, nohide
temp1:=SubStr(A_GuiControl, 1, -8)
temp2:=%A_GuiControl%
iniwrite, %temp2%, details.ini, n_var_for_tests, % temp1 . "nvar"
return

buttontest:
Process, exist, MTGA.exe
If ErrorLevel
{
Switch A_GuiControl
	{
		case "play":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, playnvar
			tempN:=tempn*5
			ImageSearch, , , 1130, 655, 1195, 720, *%tempN% *TransBlack %A_WorkingDir%\images\play.png
			If (ErrorLevel = 0)
				tempfound:=1
			else 
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "keep":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, keepnvar
			tempN:=tempn*5
			ImageSearch, , , 715, 570, 805, 635, *%tempN% *TransBlack %A_WorkingDir%\images\keep.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "next":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, nextnvar
			tempN:=tempn*5
			ImageSearch, , , 1155, 620, 1210, 650, *%tempN% *TransBlack %A_WorkingDir%\images\next.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "endturn":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, endturnnvar
			tempN:=tempn*5
			ImageSearch, , , 1135, 620, 1235, 645, *%tempN% *TransBlack %A_WorkingDir%\images\endturn.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "prize":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, prizenvar
			tempN:=tempn*5
			ImageSearch, , , 1090, 655, 1220, 690, *%tempN% *TransBlack %A_WorkingDir%\images\prize.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "draw":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, drawnvar
			tempN:=tempn*5
			ImageSearch, , , 540, 325, 745, 500, *%tempN% *TransBlack %A_WorkingDir%\images\draw.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "victory":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, victorynvar
			tempN:=tempn*5
			ImageSearch, , , 470, 325, 810, 510, *%tempN% *TransBlack %A_WorkingDir%\images\victory.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "defeat":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, defeatnvar
			tempN:=tempn*5
			ImageSearch, , , 520, 325, 760, 510, *%tempN% *TransBlack %A_WorkingDir%\images\defeat.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "island":
			WinActivate, MTGA
			MouseExpandX := 145
			MouseExpandY := 710
			IniRead, tempn, details.ini, n_var_for_tests, islandnvar
			tempN:=tempn*5
			while (MouseExpandX<1100)
				{
					WinActivate, MTGA
					MouseMove % MouseExpandX += 100, %MouseExpandY%
					sleep 150
					ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\island.png
					If (ErrorLevel = 0)
						{
							tempfound:=1
							MouseExpandX:=1100
						}
				}
			if (MouseExpandX>1100)
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "forest":
			WinActivate, MTGA
			MouseExpandX := 145
			MouseExpandY := 710
			IniRead, tempn, details.ini, n_var_for_tests, forestnvar
			tempN:=tempn*5
			while (MouseExpandX<1100)
				{
					WinActivate, MTGA
					MouseMove % MouseExpandX += 100, %MouseExpandY%
					sleep 150
					ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\forest.png
					If (ErrorLevel = 0)
						{
							tempfound:=1
							MouseExpandX:=1100
						}
				}
			if (MouseExpandX>1100)
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "mountain":
			WinActivate, MTGA
			MouseExpandX := 145
			MouseExpandY := 710
			IniRead, tempn, details.ini, n_var_for_tests, mountainnvar
			tempN:=tempn*5
			while (MouseExpandX<1100)
				{
					WinActivate, MTGA
					MouseMove % MouseExpandX += 100, %MouseExpandY%
					sleep 150
					ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\mountain.png
					If (ErrorLevel = 0)
						{
							tempfound:=1
							MouseExpandX:=1100
						}
				}
			if (MouseExpandX>1100)
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "plains":
			WinActivate, MTGA
			MouseExpandX := 145
			MouseExpandY := 710
			IniRead, tempn, details.ini, n_var_for_tests, plainsnvar
			tempN:=tempn*5
			while (MouseExpandX<1100)
				{
					WinActivate, MTGA
					MouseMove % MouseExpandX += 100, %MouseExpandY%
					sleep 150
					ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\plains.png
					If (ErrorLevel = 0)
						{
							tempfound:=1
							MouseExpandX:=1100
						}
				}
			if (MouseExpandX>1100)
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "swamp":
			WinActivate, MTGA
			MouseExpandX := 145
			MouseExpandY := 710
			IniRead, tempn, details.ini, n_var_for_tests, swampnvar
			tempN:=tempn*5
			while (MouseExpandX<1100)
				{
					WinActivate, MTGA
					MouseMove % MouseExpandX += 100, %MouseExpandY%
					sleep 150
					ImageSearch, , , % MouseExpandX -90, % MouseExpandY - 90, % MouseExpandX + 90, % MouseExpandY -10, *%tempN% *TransBlack %A_WorkingDir%\images\swamp.png
					If (ErrorLevel = 0)
						{
							tempfound:=1
							MouseExpandX:=1100
						}
				}
			if (MouseExpandX>1100)
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "first":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, firstnvar
			tempN:=tempn*5
			ImageSearch, , , 525, 40, 750, 85, *%tempN% *TransBlack %A_WorkingDir%\images\first.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "second":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, secondnvar
			tempN:=tempn*5
			ImageSearch, , , 455, 40, 825, 85, *%tempN% *TransBlack %A_WorkingDir%\images\second.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "DCed":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, DCednvar
			tempN:=tempn*5
			ImageSearch, , , 520, 285, 760, 340, *%tempN% *TransBlack %A_WorkingDir%\images\DCed.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "submit":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, submitnvar
			tempN:=tempn*5
			ImageSearch, , , 1130, 620, 1235, 650, *%tempN% *TransBlack %A_WorkingDir%\images\submit.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "active":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, activenvar
			tempN:=tempn*5
			ImageSearch, , , 200, 680, 1060, 680, *%tempN% *TransBlack %A_WorkingDir%\images\active.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "choice":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, choicenvar
			tempN:=tempn*5
			ImageSearch, , , 420, 35, 860, 80, *%tempN% *TransBlack %A_WorkingDir%\images\choice.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "cost":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, costnvar
			tempN:=tempn*5
			ImageSearch, , , 990, 630, 1060, 660, *%tempN% *TransBlack %A_WorkingDir%\images\cost.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "concede":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, concedenvar
			tempN:=tempn*5
			ImageSearch, , , 600, 400, 670, 440, *%tempN% *TransBlack %A_WorkingDir%\images\concede.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
		case "timer":
			WinActivate, MTGA
			IniRead, tempn, details.ini, n_var_for_tests, timernvar
			tempN:=tempn*5
			ImageSearch, , , 110, 280, 165, 450, *%tempN% *TransBlack %A_WorkingDir%\images\timer.png
			If (ErrorLevel = 0)
				tempfound:=1
			else
				tempfound:=0
			Sleep 100
			WinActivate, Image search setup
	}
if tempfound
	MsgBox, 270336, Success, -----------SUCCESS-----------`nfound %A_GuiControl% image
else
	MsgBox, 270384, Failure, FAILURE`n%A_GuiControl% image was not found
}
else
	MsgBox, 270336, Nope, MTGA is not open
return

imagetestpreview:
	GuiControlGet, temp1, visible, %A_GuiControl%image
	if (temp1=1)
		GuiControl, images:hide, %currentimage%image
	else
		{
			GuiControl, images:hide, %currentimage%image
			currentimage:=a_guicontrol
			GuiControl, images:show, %A_GuiControl%image
		}
	gui, images:show, autosize
return

testinstructions:
	if (testinstructionsshow=1)
		{
			gui, testinstructions:hide
			testinstructionsshow:=0
		}
	else
		{
			gui, testinstructions:show, autosize, How image test works
			testinstructionsshow:=1
		}
return

testinstructionsguiclose:
	gui, testinstructions:hide
	testinstructionsshow:=0
return

instructions:
	if (Instructionsshow=1)
		{
			gui, Instructions:hide
			Instructionsshow:=0
		}
	else
		{
			gui, Instructions:show, autosize, Instructions
			Instructionsshow:=1
		}
return

instructionsguiclose:
	gui, Instructions:hide
	Instructionsshow:=0
return

imagesguiclose:
	imageshow:=0
	GuiControl, images:hide, %currentimage%image
	gui, images:hide
return
	
mainbuttonimagetroubleshoot:
	if (imageshow=1)
		{
			GuiControl, images:hide, %currentimage%image
			gui, images:hide
			imageshow:=0
		}
	else
		{
			gui, images:show, autosize, Image search setup
			imageshow:=1
		}
return

checkruntooltip() ;------------------------------------------------------------------------------------------------------------------------------------this is the run button tooltip on mouse hover
	{
		global  FolderText, Wins#_ddl, checkb0, checkb1, checkb2, checkb3, checkb4,pausehkerror, exithkerror, runbuttontooltip
		, runbuttonx, runbuttony, runbuttonhwnd, ending_ddl, sparklyhwnd
		
		static currenthoverbutton
		
		gui, submit, nohide
		WinGetPos, mainX, mainY,,,ahk_id %sparklyhwnd%
		ControlGet, runbuttonstate, enabled,, , ahk_id %runbuttonhwnd%
		MouseGetPos,,, hoverwindow, hoverbutton, 2
		GuiControlGet, runbtn, main:pos, %runbuttonhwnd%
		runbuttontooltip:="You still need to:"
		if (pausehkerror=1)
			runbuttontooltip .= "`n Set a pause hotkey"
		if (exithkerror=1)
			runbuttontooltip .= "`n Set an exit hotkey"
		if (FolderText="")
			runbuttontooltip .= "`n Set the Mtga exe file path"
		if (Wins#_ddl="")
			runbuttontooltip .= "`n Set the number of wins"
		if (ending_ddl="")
			runbuttontooltip .= "`n Choose an action for when wins are achieved"
		if (checkb0=0)
			runbuttontooltip .= "`n Check ""remember me"" on the login page"
		if (checkb1=0)
			runbuttontooltip .= "`n Set resolution to 1280x720"
		if (checkb2=0)
			runbuttontooltip .= "`n Set Mtga to windowed mode"
		if (checkb3=0)
			runbuttontooltip .= "`n Select the desired deck"
		if (checkb4=0)
			runbuttontooltip .= "`n Return to Mtga home page"
		
		if (hoverbutton=runbuttonhwnd and runbuttonstate=0)
			{
				if (hoverbutton!=currenthoverbutton)
					{
						CoordMode, tooltip, screen
						tooltip, %runbuttontooltip%, mainX+runbtnX+4, mainY+runbtnY+runbtnH+27
					currenthoverbutton:=hoverbutton
					}
			}
			else
			{
				currenthoverbutton:=""
				ToolTip
			}
	}

changeexithotkey:
	gui, main:+disabled
	WinGetPos, mainX, mainY,,,ahk_id %sparklyhwnd%
	gui, exit:+ownermain
	gui, exit:show, % "x"mainX + 60 . " y" . mainY + 95, exit hotkey setup
	GuiControl,exit:focus, exit_hk
return

changeplayhotkey:
	gui, main:+disabled
	WinGetPos, mainX, mainY,,,ahk_id %sparklyhwnd%
	gui, pause:+ownermain
	gui, pause:show, % "x"mainX + 60 . " y" . mainY + 95, pause hotkey setup
	GuiControl,pause:focus, pause_hk
return

press_exit:
exit_script:
mainGuiClose:
	WinClose, turnloops
	IniWrite, 0, details.ini, main, playingatm
	ExitApp
return

exitbuttoncancel:
exitguiclose:
	gui, main:-Disabled
	Gui, exit:hide
return

pausebuttoncancel:
pauseguiclose:
	gui, main:-Disabled
	Gui, pause:hide
return

pausebuttonsubmit: 
	try Hotkey, %pausehktext%, Off 
	Gui, Submit, NoHide
	pausehktext := pause_hk
	pausehkerror:=0
	IniWrite, %pause_hk%, details.ini, main, pauseHK
	try Hotkey, % pausehktext, pause_script, On
	catch
		{
			pausehkerror:=1
			GuiControl, main:text, runbutton, Run`n(hotkey: Not set)
			GuiControl, main:text, pausebutton, Pause`n(hotkey: Not set)
			GuiControl, main:text, continuebutton, Continue`n(hotkey: Not set)
			enable_run()
		}
	if (pausehkerror = 0)
		{
			Gui, pause:hide
			finalpausehotkey:=strreplace(pausehktext, "+", "Shift+")
			finalpausehotkey:=strreplace(finalpausehotkey,"!","Alt+") 
			finalpausehotkey:=strreplace(finalpausehotkey,"^","Ctrl+")
			GuiControl, main:text, runbutton, Run`n(hotkey: %finalpausehotkey%)
			GuiControl, main:text, pausebutton, Pause`n(hotkey: %finalpausehotkey%)
			GuiControl, main:text, continuebutton, Continue`n(hotkey: %finalpausehotkey%)
			gui, main:-Disabled
			enable_run()
		}
Return

exitbuttonsubmit: 
	try Hotkey, %exithktext%, Off 
	Gui, Submit, NoHide
	exithktext := exit_hk
	exithkerror:=0
	IniWrite, %exit_hk%, details.ini, main, exitHK
	try Hotkey, % exithktext, exit_script, On
	catch
		{
			exithkerror:=1
			GuiControl, main:text, exitbutton, Exit`n(hotkey: Not set)
			enable_run()
		}
	if (exithkerror = 0)
		{
			Gui, exit:hide
			finalexithotkey:=strreplace(exithktext, "+", "Shift+")
			finalexithotkey:=strreplace(finalexithotkey,"!","Alt+") 
			finalexithotkey:=strreplace(finalexithotkey,"^","Ctrl+")
			GuiControl, main:text, exitbutton, Exit`n(hotkey: %finalexithotkey%)
			gui, main:-Disabled
			enable_run()
		}
Return

mainbuttonmtgapath:
	FileSelectfile, FolderText,,1
	IniWrite, %FolderText%, details.ini, main, Mtga_Path
	if (FolderText = "")
		{
			GuiControl, main:text, filetext, Please select the Mtga exe file
		}
	else
		{
			GuiControl, main:text, filetext, %FolderText%
		}
	enable_run()
return

submit_ddl:
submit_checkb:
	gui, submit, nohide
	if (a_guicontrol="Wins#_ddl")
		{
			iniwrite, %Wins#_ddl%, details.ini, main, Wins
			GuiControl,main:text, wincounter, %victorycounter%/%Wins#_ddl%
		}
	if (a_guicontrol="ending_ddl")
		{
			iniwrite, %ending_ddl%, details.ini, main, Endaction
		}	
	enable_run()
return

enable_run()
	{
	global  FolderText, Wins#_ddl, checkb0, checkb1, checkb2, checkb3, checkb4, pausehkerror, exithkerror, ending_ddl

	If (Wins#_ddl!="" and FolderText!="" and ending_ddl!="" and checkb0=1 and checkb1=1 and checkb2=1 and checkb3=1 and checkb4=1 and pausehkerror=0 and exithkerror=0 )
		{
			GuiControl, main:enable, runbutton
		}
	else
		{
			GuiControl, main:disable, runbutton
		}
	}

FormatCT(ms)
	{	
		sec := SubStr(ms, 1, -3)
		min := Floor(sec/60)
		sec := sec-(min*60)
		hrs := Floor(min/60)
		min := min-(hrs*60)
		While StrLen(sec) <> 2
			sec := "0" . sec
		While StrLen(min) <> 2
			min := "0" . min
		While StrLen(hrs) <> 2
			hrs := "0" . hrs 
		return , "Time: " hrs . ":" . min . ":" . sec
	}

FormatresetT(ms)
	{
		sec := SubStr(ms, 1, -3)
		min := Floor(sec/60)
		sec := sec-(min*60)
		hrs := Floor(min/60)
		min := min-(hrs*60)
		While StrLen(min) = 0
			min := 0
		return, sec
	}

timers:
	GuiControl, main:text, stopwatch , % FormatCT((A_TickCount - ST) + AdjTime)
return

reset:
	IniRead, continuity, details.ini, main, continuity
	if (continuity = continuitymark)
		{
			if (resetstarted = 0)
				{
					RTS := a_tickcount
					resetstarted := 1
				}
			resettime := FormatresetT((a_tickcount - RTS) + Adjreset)
			
		}
	else
		{
			Adjreset:=0
			resettime:=0
			resetstarted:=0
			continuitymark:=continuity
		}

	Process, exist, MTGA.exe
	If ErrorLevel
		{
			if(resettime>=600)
				{
					SetTimer, gamestate, off
					PostMessage, 9000,,,,turnloops
					resettime:=0
					Adjreset:=0
					resetstarted:=0
					WinClose, MTGA
					sleep 2000
				}
		}
	else
		{
			run, %FolderText%
			settimer, gamestateafterreset, 2000
			sleep 2000
		}
return

pause_script:
	gui, main:submit, nohide
	ControlGet, runbuttonstate, enabled,, , ahk_id %runbuttonhwnd%
	ControlGet, pausebuttonstate, enabled,, , ahk_id %pausebuttonhwnd%
	ControlGet, continuebuttonstate, enabled,, , ahk_id %continuebuttonhwnd%
	if (runbuttonstate=1)
		{
			WinActivate, MTGA
			GuiControl, main:disable, changeplayhk
			GuiControl, main:disable, changeexithk
			GuiControl, main:disable, filepath
			GuiControl, main:disable, filetext
			GuiControl, main:focus, pausebutton
			GuiControl, main:show, Running
			GuiControl, main:hide, Hasn't begun
			GuiControl, main:hide, runbutton
			GuiControl, main:disable, runbutton
			Guicontrol, main:show, pausebutton
			GuiControl, main:enable, pausebutton
			ST := A_TickCount ; Start Time
			settimer, timers, 250
			settimer, gamestate, 500
			settimer, reset, 1000
			run, Assistant.exe
			return
		}
	else if (pausebuttonstate=1)
		{
			PostMessage 0x111, 65306,,,turnloops
			GuiControl, main:hide, Running
			GuiControl, main:show, Paused
			GuiControl, main:hide, pausebutton
			GuiControl, main:disable, pausebutton
			Guicontrol, main:show, continuebutton
			GuiControl, main:enable, continuebutton
			SetTimer, timers, off
			AdjTime := ((A_TickCount - ST) + AdjTime)
			Adjreset := ((A_TickCount - RTS) + Adjreset)
			pause,,1
			return
		}
	else if (continuebuttonstate=1)
		{
			PostMessage 0x111, 65306,,,turnloops
			WinActivate, MTGA
			GuiControl, main:show, Running
			GuiControl, main:hide, Paused
			GuiControl, main:hide, continuebutton
			GuiControl, main:disable, continuebutton
			Guicontrol, main:show, pausebutton
			GuiControl, main:enable, pausebutton
			ST := A_TickCount
			RTS := a_tickcount
			settimer, timers, 500
			pause,, 1
			return
		}
	else
		{
		GuiControlGet, runbtn, main:pos, %runbuttonhwnd%
		WinGetPos, mainX, mainY,,,ahk_id %sparklyhwnd%
		ControlGet, runbuttonstate, enabled,, , ahk_id %runbuttonhwnd%
		runbuttontooltip:="You still need to:"
		if (pausehkerror=1)
			runbuttontooltip .= "`n Set a pause hotkey"
		if (exithkerror=1)
			runbuttontooltip .= "`n Set an exit hotkey"
		if (FolderText="")
			runbuttontooltip .= "`n Set the Mtga exe file path"
		if (Wins#_ddl="")
			runbuttontooltip .= "`n Set the number of wins"
		if (ending_ddl="")
			runbuttontooltip .= "`n Choose an action for when wins are achieved"
		if (checkb0=0)
			runbuttontooltip .= "`n Check ""remember me"" on the login page"
		if (checkb1=0)
			runbuttontooltip .= "`n Set resolution to 1280x720"
		if (checkb2=0)
			runbuttontooltip .= "`n Set Mtga to windowed mode"
		if (checkb3=0)
			runbuttontooltip .= "`n Select the desired deck"
		if (checkb4=0)
			runbuttontooltip .= "`n Return to Mtga home page"
		CoordMode, tooltip, screen
		tooltip, %runbuttontooltip%, mainX+runbtnX+4, mainY+runbtnY+runbtnH+27
	}
return



victorycheck()
	{
		global Wins#_ddl, victorycounter, ending_ddl
		
		if (Wins#_ddl=victorycounter)
			{
				switch ending_ddl
					{
							case 1: 
								victorycounter := 0
								GuiControl,main:, wincounter, %victorycounter%/%Wins#_ddl%
								GuiControl, main:hide, Running
								GuiControl, main:show, Paused
								GuiControl, main:hide, pausebutton
								GuiControl, main:disable, pausebutton
								Guicontrol, main:show, continuebutton
								GuiControl, main:enable, continuebutton
								SetTimer, timers, off
								AdjTime := ((A_TickCount - ST) + AdjTime)
								Adjreset := ((A_TickCount - RTS) + Adjreset)
								PostMessage 0x111, 65306,,,turnloops
								pause,,1
							case 2:
								WinClose, turnloops
								ExitApp
							case 3:
								WinClose, MTGA
								WinClose, turnloops
								ExitApp
							case 4:
								WinClose, MTGA
								WinClose, turnloops
								Shutdown, 5
								ExitApp
					}
					
			}
	}

gamestate() ;checks state of screen for various indicators that the match is over/needs to begin.
	{

	global victorycounter, Wins#_ddl, losscounter, continuity

	WinActivate, MTGA

	IniRead, tempn, details.ini, n_var_for_tests, DCednvar
	tempN:=tempn*5
	ImageSearch, , , 520, 285, 760, 340, *%tempN% *TransBlack %A_WorkingDir%\images\DCed.png
		If (ErrorLevel == 0)
			{
				PostMessage, 9000,,,,turnloops
				MouseMove, 700, 415
				MouseClick
				sleep 200
				MouseMove, 700, 440, 10
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, playnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1130, 655, 1195, 720, *%tempN% *TransBlack %A_WorkingDir%\images\play.png 
		If (ErrorLevel = 0)
			{
				PostMessage, 9000,,,,turnloops
				MouseMove % stateposX +100,%stateposY% 
				MouseClick
				Sleep 200
				MouseMove % stateposX +100,% stateposY -40, 10
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, keepnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 715, 570, 805, 635, *%tempN% *TransBlack %A_WorkingDir%\images\keep.png
		If (ErrorLevel = 0)
			{
				IniWrite, %continuity%, details.ini, main, continuity
				WinActivate, MTGA
				IniRead, tempn, details.ini, n_var_for_tests, secondnvar
				tempN:=tempn*5
				ImageSearch, , , 455, 40, 825, 85, *%tempN% *TransBlack %A_WorkingDir%\images\second.png
				opgoesfirst:=ErrorLevel
				WinActivate, MTGA
				IniRead, tempn, details.ini, n_var_for_tests, firstnvar
				tempN:=tempn*5
				ImageSearch, , , 525, 40, 750, 85, *%tempN% *TransBlack %A_WorkingDir%\images\first.png
				yougofirst:=ErrorLevel
				IniRead, playingatm, details.ini, main, playingatm
				if (opgoesfirst = 0 and playingatm = 0)
					{
						sleep 1500
						PostMessage, 9003,,,,turnloops
						PostMessage, 9002,,,,turnloops
					}
				if (yougofirst = 0 and playingatm = 0)
					{
						sleep 1500
						PostMessage, 9003,,,,turnloops
						PostMessage, 9001,,,,turnloops
					}
				MouseMove % stateposX +100,%stateposY% 
				MouseClick
				Sleep 200
				MouseMove % stateposX +100,% stateposY -40, 10
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, nextnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1155, 620, 1210, 650, *%tempN% *TransBlack %A_WorkingDir%\images\next.png
		If (ErrorLevel = 0)
			{
				PostMessage, 9003,,,,turnloops
				IniRead, playingatm, details.ini, main, playingatm
				if (playingatm = 0)
					{
						PostMessage, 9001,,,,turnloops
						IniWrite, 1, details.ini, main, playingatm
					}
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, endturnnvar
	tempN:=tempn*5
	ImageSearch, , , 1135, 620, 1235, 645, *%tempN% *TransBlack %A_WorkingDir%\images\endturn.png
		If (ErrorLevel = 0)
			{
				PostMessage, 9003,,,,turnloops
				IniRead, playingatm, details.ini, main, playingatm
				if (playingatm = 0)
					{
						PostMessage, 9001,,,,turnloops
						IniWrite, 1, details.ini, main, playingatm
					}
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, prizenvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1090, 655, 1220, 690, *%tempN% *TransBlack %A_WorkingDir%\images\prize.png
		If (ErrorLevel = 0)
			{
				PostMessage, 9000,,,,turnloops
				MouseMove % stateposX +100,%stateposY% 
				MouseClick
				Sleep 200
				MouseMove % stateposX +100,% stateposY -40, 10
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, concedenvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 600, 400, 670, 440, *%tempN% *TransBlack %A_WorkingDir%\images\concede.png
		If (ErrorLevel = 0)
			{
				PostMessage, 9000,,,,turnloops
				MouseMove %stateposX%,%stateposY%
				MouseClick
				Sleep 200
				MouseMove % stateposX -70, %stateposY%,10
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, defeatnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 520, 325, 760, 510, *%tempN% *TransBlack %A_WorkingDir%\images\defeat.png
		If (ErrorLevel = 0)
			{
				losscounter++
				GuiControl,main:, losscounter, %losscounter%
				PostMessage, 9000,,,,turnloops
				MouseMove %stateposX%,%stateposY% 
				MouseClick
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, drawnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 540, 325, 745, 500, *%tempN% *TransBlack %A_WorkingDir%\images\draw.png
		If (ErrorLevel = 0)
			{
				PostMessage, 9000,,,,turnloops
				MouseMove %stateposX%,%stateposY% 
				MouseClick
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, victorynvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 470, 325, 810, 510, *%tempN% *TransBlack %A_WorkingDir%\images\victory.png ;needs more work
		If (ErrorLevel = 0)
			{
				victorycounter++
				GuiControl,main:, wincounter, %victorycounter%/%Wins#_ddl%
				PostMessage, 9000,,,,turnloops
				MouseMove %stateposX%,%stateposY% 
				MouseClick
				Loop
					{
						sleep 1000
						WinActivate, MTGA
						IniRead, tempn, details.ini, n_var_for_tests, victorynvar
						tempN:=tempn*5
						ImageSearch, stateposX, stateposY, 470, 325, 810, 510, *%tempN% *TransBlack %A_WorkingDir%\images\victory.png
						if (errorlevel =0)
							{
								MouseMove %stateposX%,%stateposY% 
								MouseClick
							}
						WinActivate, MTGA
						IniRead, tempn, details.ini, n_var_for_tests, playnvar
						tempN:=tempn*5
						ImageSearch, stateposX, stateposY, 1130, 655, 1195, 720, *%tempN% *TransBlack %A_WorkingDir%\images\play.png
						playdetect:=ErrorLevel
						WinActivate, MTGA
						IniRead, tempn, details.ini, n_var_for_tests, prizenvar
						tempN:=tempn*5
						ImageSearch, stateposX, stateposY, 1090, 655, 1220, 690, *%tempN% *TransBlack %A_WorkingDir%\images\prize.png
						prizedetect:=ErrorLevel
						If (prizedetect = 0 or playdetect = 0)
							{
								sleep 2000
								WinActivate, MTGA
								IniRead, tempn, details.ini, n_var_for_tests, prizenvar
								tempN:=tempn*5
								ImageSearch, stateposX, stateposY, 1090, 655, 1220, 690, *%tempN% *TransBlack %A_WorkingDir%\images\prize.png
								if (errorlevel = 0)
									{
										MouseMove, 600, 600
										MouseClick
										Sleep 1000
										victorycheck()
										break
									}
								WinActivate, MTGA
								IniRead, tempn, details.ini, n_var_for_tests, playnvar
								tempN:=tempn*5
								ImageSearch, stateposX, stateposY, 1130, 655, 1195, 720, *%tempN% *TransBlack %A_WorkingDir%\images\play.png
								If (errorlevel = 0)
									{
										victorycheck()
										;this happens only if there are no more prizes to be gained
										break
									}
							}
					}
			}
	}

gamestateafterreset()
	{

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, DCednvar
	tempN:=tempn*5
	ImageSearch, , , 520, 285, 760, 340, *%tempN% *TransBlack %A_WorkingDir%\images\DCed.png
		If (ErrorLevel == 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, playnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1130, 655, 1195, 720, *%tempN% *TransBlack %A_WorkingDir%\images\play.png 
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, keepnvar
	tempN:=tempn*5
	ImageSearch, , , 715, 570, 805, 635, *%tempN% *TransBlack %A_WorkingDir%\images\keep.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, nextnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1155, 620, 1210, 650, *%tempN% *TransBlack %A_WorkingDir%\images\next.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, endturnnvar
	tempN:=tempn*5
	ImageSearch, , , 1135, 620, 1235, 645, *%tempN% *TransBlack %A_WorkingDir%\images\endturn.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, prizenvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 1090, 655, 1220, 690, *%tempN% *TransBlack %A_WorkingDir%\images\prize.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, concedenvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 600, 400, 670, 440, *%tempN% *TransBlack %A_WorkingDir%\images\concede.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, defeatnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 520, 325, 760, 510, *%tempN% *TransBlack %A_WorkingDir%\images\defeat.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, drawnvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 540, 325, 745, 500, *%tempN% *TransBlack %A_WorkingDir%\images\draw.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}

	WinActivate, MTGA
	IniRead, tempn, details.ini, n_var_for_tests, victorynvar
	tempN:=tempn*5
	ImageSearch, stateposX, stateposY, 470, 325, 810, 510, *%tempN% *TransBlack %A_WorkingDir%\images\victory.png
		If (ErrorLevel = 0)
			{
				settimer, gamestateafterreset, Off
				settimer, gamestate, on
				Exit
			}
	}


