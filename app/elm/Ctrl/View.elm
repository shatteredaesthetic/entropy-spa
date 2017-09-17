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
    gameBtnsWrap [] [ restartBtn, resetBtn ]


breakBtns : Html Action
breakBtns =
    breakBtnsWrap [] [ resetBtn, roundBtn ]


cfgBtns : Html Action
cfgBtns =
    cfgBtnsWrap [] [ startBtn ]


goBtns : Html Action
goBtns =
    goBtnsWrap [] [ gameOverBtn ]


startBtn : Html Action
startBtn =
    btnWrap [ onClick (Btn StartGame) ] [ text "Start Game" ]


roundBtn : Html Action
roundBtn =
    btnWrap [ onClick (Btn NextRound) ] [ text "Next Round" ]


restartBtn : Html Action
restartBtn =
    btnWrap [ onClick (Btn Restart) ] [ text "Restart" ]


resetBtn : Html Action
resetBtn =
    btnWrap [ onClick (Btn Reset) ] [ text "Reset" ]


gameOverBtn : Html Action
gameOverBtn =
    btnWrap [ onClick (Btn Reset) ] [ text "Play Again?" ]


gameBtnsWrap : StyledComponent
gameBtnsWrap =
    styled div
        [ display flex_
        , justifyContent spaceAround
        , alignContent center
        , flexDirection column
        , width (percent 50)
        , height (percent 50)
        ]


breakBtnsWrap : StyledComponent
breakBtnsWrap =
    styled stretchWrap
        [ display flex_
        , justifyContent spaceAround
        , alignItems center
        , backgroundColor (hex "1c1c38")
        ]


cfgBtnsWrap : StyledComponent
cfgBtnsWrap =
    styled centerWrap
        [ backgroundColor (hex "777f91")
        , flex (int 1) (int 0) auto
        ]


goBtnsWrap : StyledComponent
goBtnsWrap =
    styled centerWrap
        [ backgroundColor (hex "1c1c38")
        , flex (int 1) (int 0) (percent 25)
        ]


btnWrap : StyledComponent
btnWrap =
    styled centerWrap
        [ cursor pointer
        , backgroundColor (hex "224f75")
        , color (hex "faf9f9")
        , borderRadius (px 5)
        , padding (px 10)
        , border (px 1) solid (hex "1c1c38")
        ]
