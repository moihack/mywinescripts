Sleep 20000 ; wait for game to load and reach the menu

Send {Right down} ; right arrow even if pressed longer won't toggle a wrong option in menu
Sleep 500
Send {Right up}

Sleep 3000 ; wait for menu to show up correctly

Send {Enter down} ;start Benchmark
Sleep 500 ; keep Enter a little bit pressed in case the menu hasn't loaded yet
Send {Enter up}

Sleep 90000 ; spend some time running the benchmark
;NOTE: some time may be lost while loading the benchmark

;we do not run through the whole benchmark yet,since it is quite big in duration

Send !{f4} ;force quit the game with Alt+F4 instead of walking through the menu

Return
