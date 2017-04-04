module Ctrl.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Util.View exposing (..)
import Ctrl.Types exposing (..)
import Util.Types exposing (..)


gameBtns : Html Action
gameBtns =
    div
        [ class "btn-container game-btns"
        , styleList [ flexStyle, centerStyle, columnStyle, stretchStyle ]
        ]
        [ restartBtn
        , resetBtn
        ]


breakBtns : Html Action
breakBtns =
    div
        [ class "btn-container break-btns"
        , styleList [ flexStyle, stretchStyle, jcStyle "space-around", aiStyle "center" ]
        ]
        [ resetBtn
        , roundBtn
        ]


configBtn : Html Action
configBtn =
    div
        [ class "btn-container cfg-btns"
        , styleList [ flexStyle, centerStyle, bgColor "#d8d8d8", flex 1 0 ]
        ]
        [ startBtn ]


resetBtn : Html Action
resetBtn =
    div
        [ class "reset-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn Reset)
        ]
        [ text "Reset" ]


restartBtn : Html Action
restartBtn =
    div
        [ class "restart-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn Restart)
        ]
        [ text "Restart" ]


roundBtn : Html Action
roundBtn =
    div
        [ class "next-round-btn"
        , styleList [ flexStyle, centerStyle, btnStyle ]
        , onClick (Btn NextRound)
        ]
        [ text "Next Round" ]


startBtn : Html Action
startBtn =
    div
        [ class "start-game-btn"
        , styleList [ flexStyle, centerStyle, btnStyle, styledBtnStyle ]
        , onClick (Btn StartGame)
        ]
        [ text "Start Game" ]
