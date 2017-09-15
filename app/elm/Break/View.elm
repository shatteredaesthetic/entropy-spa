module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Util.Types exposing (..)
import Game.Board.View as Board
import Ctrl.View exposing (breakBtns)
import Styled exposing (..)


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


breakCont : StyledComponent
breakCont =
    styled div
        [ display flex_
        , width (percent 100)
        , height (percent 100)
        ]


middleCont : StyledComponent
middleCont =
    styled div
        [ display flex_
        , flexDirection column
        ]


breakBd : StyledComponent
breakBd =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        , height (percent 70)
        ]


plyrPanelCont : StyledComponent
plyrPanelCont =
    styled div
        [ display flex_
        , flexDirection column
        , width (percent 25)
        ]


scoreCont : StyledComponent
scoreCont =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        , backgroundColor (hex "d8d8d8")
        , color (hex "1e0812")
        , fontSize (em 7)
        ]


nameCont : StyledComponent
nameCont =
    styled div
        [ display flex_
        , alignItems center
        , backgroundColor (hex "d8d8d8")
        , color (hex "1e0812")
        , fontSize (em 5)
        ]
