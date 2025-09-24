#SingleInstance Ignore

GetCurrentMonitor() {
    MouseGetPos &mouse_x, &mouse_y
    
    mon := 0
    monCount := MonitorGetCount()
    loop monCount
    {
        MonitorGet A_Index, &Left, &Top, &Right, &Bottom
        if (mouse_x >= left && mouse_x <= right && mouse_y >= top && mouse_y <= bottom) {
            mon := A_Index
            break
        }
    }
    return mon
}

GetWindowsInMonitor() {
    wins := []
    MonitorGet GetCurrentMonitor(), &Left, &Top, &Right, &Bottom
    
    for wind in WinGetList() {
        win := WinExist(wind)
        if !win
            return

        WinGetPos &X, &Y, &W, &H, win
        X := X + (W/2)
        
        if(X < (Right) && X > (Left)){
            title := WinGetTitle(win)
            if (title != "" && title != "Program Manager" && WinGetClass(win) != "TopLevelWindowForOverflowXamlIsland"){
                wins.push(win)
            }
        }
    }
    return wins
}

changeWinOption(winOpts, index){
    for (w in winOpts){
        if(A_Index == index){
            winOpts[A_Index].opt("Background60576e")
        }
        else{
            winOpts[A_Index].opt("BackgroundTrans")
        }
        winOpts[A_Index].redraw()
    }
}

createTabsGUI(){
    global windows := GetWindowsInMonitor()
    global winOpts := []
    global mygui
    mygui := Gui("-Caption +AlwaysOnTop", , )
    MyGui.BackColor := "2f2a36"

    for (w in windows){
        winOpts.push(myGui.Add("Text", "ce9e4f0 w320 h15", WinGetTitle(w)))
    }
    changeWinOption(winOpts, 2)
    MonitorGet GetCurrentMonitor(), &Left, &Top, &Right, &Bottom
    Left := Left + ((Right-Left)/2) - 150
    Top := Top + ((Bottom-Top)/2) - 50
    mygui.Show(Format("x{} y{}", Left, Top))
}

!Tab::{
    CoordMode "Mouse" , "Screen"
    global optIndex := 2
    createTabsGUI()

    first := 1
    while(GetKeyState("LAlt", "P")){
        if(GetKeyState("Tab", "p")){
            if(first = 1){
                sleep(200)
                first := 0
                continue
            }
            optIndex := optIndex + 1
            if(optIndex > winOpts.length){
                optIndex := 1
            }
            changeWinOption(winOpts, optIndex)
            sleep(150)
        }
    }
    myGui.destroy()
    WinActivate(windows[optIndex])
}