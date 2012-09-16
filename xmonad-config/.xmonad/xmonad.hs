import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.EwmhDesktops
import System.IO

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["web", "irc", "code" ] ++ map show [4..9]

myManageHook = composeAll
    [ className =? "vlc"        --> doFloat
    ]

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = myManageHook
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#3399ff" "" . shorten 30
                        , ppCurrent = xmobarColor "#3399ff" "" . wrap "[" "]"
                        }
        , modMask    = mod4Mask     --Rebind Mod to Windows key
        , terminal   = "urxvtc -e bash -c 'tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME'"
        , handleEventHook    = fullscreenEventHook
        , workspaces = myWorkspaces
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask, xK_t), spawn "urxvtc")
        , ((0, 0x1008FF1D), spawn "xlock -mode blank")
        , ((0, 0x1008FF12), spawn "amixer set Master toggle")
        , ((0, 0x1008FF11), spawn "amixer set Master 2-")
        , ((0, 0x1008FF13), spawn "amixer set Master 2+")
        , ((0, 0x1008FF8F), spawn "synclient TouchpadOff=0")
        , ((0, 0x1008FF59), spawn "synclient TouchpadOff=1")
        , ((0, 0x1008FF14), spawn "urxvtc -e bash -c 'cmus-remote -u || cmus'")
        , ((0, 0x1008FF16), spawn "urxvtc -e bash -c 'cmus-remote -r || cmus'")
        , ((0, 0x1008FF17), spawn "urxvtc -e bash -c 'cmus-remote -n || cmus'")
        , ((mod4Mask, 0x1008FF17), spawn "urxvtc -e bash -c 'cmus-remote -S || cmus'")
        ]
