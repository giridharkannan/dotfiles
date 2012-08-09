import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.EwmhDesktops
import System.IO

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#3399ff" "" . shorten 30
                        , ppCurrent = xmobarColor "#3399ff" "" . wrap "[" "]"
                        }
        , modMask    = mod4Mask     --Rebind Mod to Windows key
        , terminal   = "urxvt"
        , handleEventHook    = fullscreenEventHook
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xlock -mode blank")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, 0x1008FF12), spawn "amixer set Master toggle")
        , ((0, 0x1008FF11), spawn "amixer set Master 2-")
        , ((0, 0x1008FF13), spawn "amixer set Master 2+")
        ]
