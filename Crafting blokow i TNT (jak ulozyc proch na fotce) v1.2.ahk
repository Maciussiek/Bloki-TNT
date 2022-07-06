#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, -1
global hotkey1, tryb, paski, guiscale
global xStart, yStart, xInventory, yInventory, xCrafting, yCrafting, xGetCreatedItems, xGetCreatedItems
global rowCounter := 0, colCounter := 0
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

Bloczki(){
    if A_Cursor = Unknown
        return
    MouseGetPos xStart, yStart

    if guiscale = GuiScale: NORMAL
    {
        xInventory := xStart - 140 ; kordy pierwszego slota eq os X
        yInventory:= yStart + 20 ; kordy pierwszego slota eq os Y
        xCrafting := xStart - 100 ; kordy slota w craftingu
        yCrafting := yStart - 120 ; kordy slota w craftingu
        xGetCreatedItems := xStart + 80 ; kordy gdzie obierasz bloki
        xGetCreatedItems := yStart - 80 ; Y gdzie odbierasz bloki
        deltaSLOTA = 35
    } else {
        xInventory := xStart - 220 ; kordy pierwszego slota eq os X
        yInventory := yStart + 20 ; kordy pierwszego slota eq os Y
        xCrafting := xStart - 150 ; kordy slota w craftingu
        yCrafting := yStart - 180 ; kordy slota w craftingu
        xGetCreatedItems := xStart + 130 ; kordy gdzie obierasz bloki
        yGetCreatedItems := yStart - 120 ; Y gdzie odbierasz bloki
        deltaSLOTA = 56
    }

    loop %paski%
    {
        if A_Cursor = Unknown
            return
        loop 9 {
            if A_Cursor = Unknown
                return
            if (tnt = 1) and (mod(colCounter,2))
                xInventory := xInventory + 4 * deltaSLOTA
            if rowCounter = 3
            {	
                if guiscale = GuiScale: NORMAL
                {
                    xCrafting := xStart - 100 ; kordy slota w craftingu
                    yCrafting := yCrafting + 30 ; kordy slota w craftingu
                }
                else {
                    xCrafting := xStart - 160
                    yCrafting := yCrafting + 50
                }
                rowCounter := 0
            }
            click %xInventory%, %yInventory% ; klik w eq
            sleep 30
            click %xCrafting%, %yCrafting% ;klik w craftingu
            sleep 50

            if (tnt = 1) and (mod(colCounter,2))
                xInventory := xInventory - 5 * deltaSLOTA

            xInventory := xInventory + deltaSLOTA
            xCrafting := xCrafting + deltaSLOTA
            rowCounter++
            colCounter++
        }

        sleep 10
        send {LSHIFT down} ;odbieram bloki z craftingu
        sleep 10
        click %xGetCreatedItems%, %yGetCreatedItems%
        sleep 20
        send {LSHIFT up}
        
        yInventory:= yInventory+ deltaSLOTA ; zeby zjerzało na kolejny wiersz
        if guiscale = GuiScale: NORMAL
        {
            xInventory := xStart - 144 ; kordy pierwsze
            xCrafting := xStart - 101 ; kordy slota w craftingu
            yCrafting := yStart - 118 ; kordy slota w craftingu
        }
        else {
            xInventory := xStart - 223 ; kordy pierwszego slota na osi X
            xCrafting := xStart - 153 ; kordy slota w craftingu
            yCrafting := yStart - 177 ; kordy slota w craftingu
        }

        rowCounter := 0
        colCounter := 0
    }

    return
}

START:
    Gui submit
    Gui hide
    Hotkey, ~*$%hotkey1%, Bloczki
Return

GuiEscape:
GuiClose:
ExitApp
