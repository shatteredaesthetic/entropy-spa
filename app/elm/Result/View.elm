module Result.View exposing (..)

import Html exposing (Html, div, h3, text)
import Styled exposing (..)
import Util.Types exposing (..)
import Game.Board.View as Board
import Util.View exposing (..)
import Ctrl.View exposing (goBtns)


resultUI : InGameState -> Html Action
resultUI state =
    resultCont []
        [ sidePanel state.player1
        , middlePanel state
        , sidePanel state.player2
        ]


sidePanel : Player -> Html Action
sidePanel plyr =
    sideCont [] [ plyrPanel plyr ]


middlePanel : InGameState -> Html Action
middlePanel state =
    middleCont []
        [ winnerCont [] [ text <| getWinner state ]
        , Board.view state.board
        , goBtns
        ]


plyrPanel : Player -> Html Action
plyrPanel plyr =
    plyrCont []
        [ nameCont [] [ text plyr.name ]
        , scoreCont [] [ text <| toString plyr.score ]
        ]


resultCont : StyledComponent
resultCont =
    styled stretchWrap [ display flex_ ]


plyrCont : StyledComponent
plyrCont =
    styled columnWrap
        [ justifyContent center
        , alignItems center
        ]


nameCont : StyledComponent
nameCont =
    styled centerWrap
        [ color (hex "98dafc")
        , textShadow zero zero (px 10) (hex "feffff")
        , backgroundColor (hex "312c32")
        , fontSize (em 2)
        ]


scoreCont : StyledComponent
scoreCont =
    styled centerWrap
        [ color (hex "feffff")
        , textShadow zero zero (px 10) (hex "98dafc")
        , backgroundColor (hex "daad86")
        , fontSize (em 4)
        ]


sideCont : StyledComponent
sideCont =
    styled columnWrap
        [ justifyContent flexEnd
        , alignItems stretch
        , flex (int 1) (int 0) (percent 20)
        , paddingBottom (Styled.rem 1)
        ]


middleCont : StyledComponent
middleCont =
    styled columnWrap [ flex (int 3) (int 0) (percent 60) ]


winnerCont : StyledComponent
winnerCont =
    styled centerWrap
        [ color (hex "98dafc")
        , backgroundColor (hex "312c32")
        , textShadow zero zero (px 10) (hex "daad86")
        , fontSize (em 5)
        ]


getWinner : InGameState -> String
getWinner { player1, player2 } =
    case compare player1.score player2.score of
        LT ->
            player2.name ++ "Wins!"

        GT ->
            player1.name ++ "Wins!"

        EQ ->
            "It's a Draw!"
