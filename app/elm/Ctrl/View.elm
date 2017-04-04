module Ctrl.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, id)
import Html.Events exposing (onClick)
import Util.View exposing (..)
import Ctrl.Types exposing (..)
import Util.Types exposing (..)


gameBtns : Html Action
gameBtns =
    div
        [ id "btn-container game-btns"
        , styleList [ flexStyle, centerStyle, columnStyle, stretchStyle ]
        ]
        [ restartBtn
        , resetBtn
        ]


breakBtns : Html Action
breakBtns =
    div
        [ id "btn-container break-btns"
        , styleList [ flexStyle, stretchStyle, jcStyle "space-around", aiStyle "center" ]
        ]
        [ resetBtn
        , roundBtn
        ]


configBtn : Html Action
configBtn =
    div
        [ id "btn-container cfg-btns"
        , styleList [ flexStyle, centerStyle, bgColor "#d8d8d8", flex 1 0 ]
        ]
        [ startBtn ]


resetBtn : Html Action
resetBtn =
    div
        [ id "reset-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn Reset)
        ]
        [ text "Reset" ]


restartBtn : Html Action
restartBtn =
    div
        [ id "restart-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn Restart)
        ]
        [ text "Restart" ]


roundBtn : Html Action
roundBtn =
    div
        [ id "next-round-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn NextRound)
        ]
        [ text "Next Round" ]


startBtn : Html Action
startBtn =
    div
        [ id "start-game-btn"
        , styleList [ flexStyle, centerStyle, btnStyle, styledBtnStyle ]
        , onClick (Btn StartGame)
        ]
        [ text "Start Game" ]
