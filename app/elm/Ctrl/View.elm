module Ctrl.View exposing (..)

import Html exposing (Html, div, text)
import Html.Events exposing (onClick)
import Ctrl.Types exposing (..)
import Util.Types exposing (..)
import Ctrl.Styles exposing (..)


{ id, class, classList } =
    ctrlNS


gameBtns : Html Action
gameBtns =
    div
        [ id GameBtns ]
        [ restartBtn
        , resetBtn
        ]


breakBtns : Html Action
breakBtns =
    div
        [ id BreakBtns ]
        [ resetBtn
        , roundBtn
        ]


configBtn : Html Action
configBtn =
    div
        [ id ConfigBtn ]
        [ startBtn ]


resetBtn : Html Action
resetBtn =
    div
        [ class BtnBase, onClick (Btn Reset) ]
        [ text "Reset" ]


restartBtn : Html Action
restartBtn =
    div
        [ class BtnBase
        , onClick (Btn Restart)
        ]
        [ text "Restart" ]


roundBtn : Html Action
roundBtn =
    div
        [ class BtnBase
        , onClick (Btn NextRound)
        ]
        [ text "Next Round" ]


startBtn : Html Action
startBtn =
    div
        [ id StartBtn
        , onClick (Btn StartGame)
        ]
        [ text "Start Game" ]
