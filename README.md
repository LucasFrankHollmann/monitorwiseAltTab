# monitorwiseAltTab
AutoHotKey script to overwrite the ```alt+tab``` switch between windows feature with a version that only considers windows in the current monitor when switching windows.

# Installation

- Download and install AutoHotKey v2 ```https://www.autohotkey.com/v2/```
- Run ```monitorwiseAltTab.ahk```

# Usage
- Press ```alt + tab``` to open the window list popup. Only windows in the monitor where the mouse cursor currently is are shown.
- The window list is shown in order by how recently each window was accessed.
- Press ```tab``` while holding ```alt``` to select the next window in the list, until you get to the window you want to switch to. Release ```alt``` to go to the selected window.
- Quickly pressing ```alt + tab``` and releasing both keys will switch you to the last window you visited in the current monitor before the current one.
