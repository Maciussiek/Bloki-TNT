#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, -1
global hotkey1, tryb, paski, guiscale
global Xstart, Ystart, X, Y, X2, Y2, X3, Y3
global i := 0, l := 0
global tnt = 1, bloki
global deltaSLOTA
global colorC2, colorC
Gui Add, GroupBox, x8 y3 w266 h51 +Center, Wybierz binda
Gui Add, Hotkey, x18 y23 w243 h21 vhotkey1
Gui Add, GroupBox, x6 y52 w266 h51 +Center, Ile pasków w GUI chcesz zapełnić?
Gui Add, Slider, x34 y73 w213 h23 +0x40 +Tooltip vpaski range1-4, 3
Gui Add, GroupBox, x7 y104 w265 h55 +Center , GUI SCALE
Gui Add, DropDownList, x21 y125 w240 vguiscale choose2, GuiScale: NORMAL|GuiScale: LARGE
Gui Add, Button, x101 y175 w80 h23 gSTART, ZACZYNAMY 

Gui Show, w281 h209, Crafting itemków Maciusssiek
Return

START:
Gui submit
Gui hide
Hotkey, ~*$%hotkey1%, Bloczki




loop
sleep 1


Bloczki(){
if A_Cursor = Unknown
return
MouseGetPos Xstart, Ystart
X := Xstart - 223 ; kordy pierwszego slota eq os X
Y := Ystart + 21 ; kordy pierwszego slota eq os Y
if guiscale = GuiScale: NORMAL
{
X := Xstart - 144 ; kordy pierwszego slota eq os X
Y := Ystart + 18 ; kordy pierwszego slota eq os Y
}


X2 := Xstart - 153 ; kordy slota w craftingu
Y2 := Ystart - 177 ; kordy slota w craftingu
if guiscale = GuiScale: NORMAL
{
X2 := Xstart - 101 ; kordy slota w craftingu
Y2 := Ystart - 118 ; kordy slota w craftingu
}

X3 := Xstart + 133 ; kordy gdzie obierasz bloki
Y3 := Ystart - 122 ; Y gdzie odbierasz bloki
if guiscale = GuiScale: NORMAL
{
X3 := Xstart + 85 ; kordy gdzie obierasz bloki
Y3 := Ystart - 77 ; Y gdzie odbierasz bloki
}
deltaSLOTA = 56

if guiscale = GuiScale: NORMAL
{
deltaSLOTA = 35
}

loop %paski%
{
if A_Cursor = Unknown
return
	loop 9 {
		if A_Cursor = Unknown
		return
		if (tnt = 1) and (l = 1 or l = 3 or l = 5 or l = 7)
			X := X + 4 * deltaSLOTA
		if i = 3
		{	
				if guiscale = GuiScale: NORMAL
				{
					X2 := Xstart - 104 ; kordy slota w craftingu
					Y2 := Y2 + 32 ; kordy slota w craftingu
				}
				else {
						X2 := Xstart - 160
						Y2 := Y2 + 50
					}
			i := 0
		}
		click %X%, %Y% ; klik w eq
		sleep 1
		click %X2%, %Y2% ;klik w craftingu
		sleep 1
		if (tnt = 1) and (l = 1 or l = 3 or l = 5 or l = 7)
			X := X - 5 * deltaSLOTA
		X := X + deltaSLOTA
		X2 := X2 + deltaSLOTA
		i++
		l++
	}
	
sleep 10
send {LSHIFT down} ;odbieram bloki z craftingu
sleep 250
click %X3%, %Y3%
sleep 40
send {LSHIFT up}
sleep 80
tooltip,
Y := Y + deltaSLOTA ; zeby zjerzało na kolejny wiersz
	if guiscale = GuiScale: NORMAL
				{
					X := Xstart - 144 ; kordy pierwsze
					X2 := Xstart - 101 ; kordy slota w craftingu
					Y2 := Ystart - 118 ; kordy slota w craftingu
				}
				else {
						X := Xstart - 223 ; kordy pierwszego slota na osi X
						X2 := Xstart - 153 ; kordy slota w craftingu
						Y2 := Ystart - 177 ; kordy slota w craftingu
					}

i := 0
l := 0
}

return
}

GuiEscape:
GuiClose:
    ExitApp
