;the various sleep times used have the following purpose
;when a game animation plays like e.g. main menu appearing
;(the moment you hear 'Devil May Cry')
;input cannot be immediately registered before animation finishes

;also hold down a key too much time
;and you can ensure you will select the wrong menu item

;since this script is about the retail 1.0.0 SecuROM version
;we also have to deal with some nasty SecuROM disc loading times
;NOTE: the original disc must be in the tray for the game to even launch

Sleep 50000 ; wait for game to load and reach the menu

Send {Right down} ; right arrow even if pressed longer won't toggle a wrong option in menu
Sleep 500
Send {Right up}

Sleep 3000 ; wait for menu to show up correctly

Send {Down down}
Sleep 100
Send {Down up}

Send {Down down}
Sleep 100
Send {Down up}

Sleep 100

Send {Enter down} ;start Benchmark
Sleep 100
Send {Enter up}

Sleep 60000 ; spend some time running the benchmark
;NOTE: some time may be lost during loading of the benchmark due to SecuROM

;we do not run through the whole benchmark yet,since it is quite big in duration
Send {Esc down} ; quit the benchmark
Sleep 500
Send {Esc up}

Sleep 5000 ; wait for menu animation to finish before pressing any keys
;again make sure we get to hear 'Devil May Cry' before proceeding

Send {Right down}
Sleep 100
Send {Right up}

Sleep 5000

Send {Down down}
Sleep 100
Send {Down up}

Sleep 100

Send {Down down}
Sleep 100
Send {Down up}

Sleep 100

Send {Down down}
Sleep 100
Send {Down up}

Send {Enter down} ;press Quit
Sleep 100
Send {Enter up}

Send {Left down} ;select Yes
Sleep 100
Send {Left up}

Send {Enter down} ;really Quit
Sleep 100
Send {Enter up}

Return
