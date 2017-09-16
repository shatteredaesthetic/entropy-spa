module Ctrl.View exposing (..)

import Html exposing (Html, div, text)
import Html.Events exposing (onClick)
import Styled exposing (..)
import Styled.Cursors exposing (pointer)
import Ctrl.Types exposing (..)
import Util.Types exposing (..)
import Util.View exposing (..)


gameBtns : Html Action
gameBtns =
    gameBtnsCont [] [ restartBtn, resetBtn ]


breakBtns : Html Action
breakBtns =
    breakBtnsCont [] [ resetBtn, roundBtn ]


cfgBtns : Html Action
cfgBtns =
    cfgBtnsCont [] [ startBtn ]


startBtn : Html Action
startBtn =
    btnCont [ onClick (Btn StartGame) ] [ text "Start Game" ]


roundBtn : Html Action
roundBtn =
    btnCont [ onClick (Btn NextRound) ] [ text "Next Round" ]


restartBtn : Html Action
restartBtn =
    btnCont [ onClick (Btn Restart) ] [ text "Restart" ]


resetBtn : Html Action
resetBtn =
    btnCont [ onClick (Btn Reset) ] [ text "Reset" ]


gameBtnsCont : StyledComponent
gameBtnsCont =
    styled div
        [ display flex_
        , justifyContent spaceAround
        , alignContent center
        , flexDirection column
        , width (percent 50)
        , height (percent 50)
        ]


breakBtnsCont : StyledComponent
breakBtnsCont =
    styled stretchWrap
        [ display flex_
        , justifyContent spaceAround
        , alignItems center
        ]


cfgBtnsCont : StyledComponent
cfgBtnsCont =
    styled centerWrap
        [ backgroundColor (hex "d8d8d8")
        , flex (int 1) (int 0) auto
        ]


btnCont : StyledComponent
btnCont =
    styled centerWrap
        [ cursor pointer
        , backgroundColor (hex "b61e64")
        , color (hex "fafafa")
        , borderRadius (px 5)
        , padding (px 10)
        , border (px 1) solid (hex "1e0812")
        ]
