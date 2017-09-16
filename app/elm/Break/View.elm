module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Styled exposing (..)
import Util.Types exposing (..)
import Game.Board.View as Board
import Ctrl.View exposing (breakBtns)
import Util.View exposing (..)


breakUI : InGameState -> Html Action
breakUI state =
    breakCont []
        [ plyrPanel state.player1
        , middlePanel state.board
        , plyrPanel state.player2
        ]


middlePanel : Board -> Html Action
middlePanel board =
    middleCont []
        [ breakBd [] [ Board.view board ]
        , breakBtns
        ]


plyrPanel : Player -> Html Action
plyrPanel plyr =
    plyrPanelCont []
        [ nameCont [] [ text plyr.name ]
        , scoreCont [] [ text <| toString plyr.score ]
        ]


middleCont : StyledComponent
middleCont =
    styled columnWrap [ flex (int 3) (int 0) (percent 60) ]


breakCont : StyledComponent
breakCont =
    styled stretchWrap [ display flex_ ]


breakBd : StyledComponent
breakBd =
    styled centerWrap [ height (percent 70) ]


plyrPanelCont : StyledComponent
plyrPanelCont =
    styled columnWrap
        [ width (percent 25)
        , flex (int 1) (int 0) (percent 20)
        ]


scoreCont : StyledComponent
scoreCont =
    styled centerWrap
        [ backgroundColor (hex "daad86")
        , color (hex "312c32")
        , fontSize (em 7)
        ]


nameCont : StyledComponent
nameCont =
    styled div
        [ display flex_
        , alignItems center
        , backgroundColor (hex "89dafc")
        , color (hex "312c32")
        , fontSize (em 5)
        ]
