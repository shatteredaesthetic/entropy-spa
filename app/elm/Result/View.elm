module Result.View exposing (..)

import Html exposing (Html, div, h3, text)
import Styled exposing (..)
import Util.Types exposing (..)
import Game.Board.View as Board
import Util.View exposing (..)
import Ctrl.View exposing (goBtns)


resultUI : InGameState -> Html Action
resultUI state =
    resultWrap []
        [ sidePanel state.player1
        , middlePanel state
        , sidePanel state.player2
        ]


middlePanel : InGameState -> Html Action
middlePanel state =
    middleWrap []
        [ middleTopWrap []
            [ winnerWrap [] [ text <| getWinner state ]
            , Board.view state.board
            ]
        , goBtns
        ]


middleTopWrap : StyledComponent
middleTopWrap =
    styled columnWrap [ flex (int 3) (int 0) (percent 60) ]


resultWrap : StyledComponent
resultWrap =
    styled stretchWrap [ display flex_ ]


middleWrap : StyledComponent
middleWrap =
    styled columnWrap
        [ flex (int 3) (int 0) (percent 60)
        , justifyContent spaceAround
        ]


winnerWrap : StyledComponent
winnerWrap =
    styled centerWrap
        [ color (hex "faf9f9")
        , backgroundColor (hex "1c1c38")
        , textShadow zero zero (px 10) (hex "870d3a")
        , fontSize (em 5)
        ]


getWinner : InGameState -> String
getWinner { player1, player2 } =
    case compare player1.score player2.score of
        LT ->
            player2.name ++ " Wins!"

        GT ->
            player1.name ++ " Wins!"

        EQ ->
            "It's a Draw!"
