module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Board.View as Board
import Ctrl.View exposing (breakBtns)


{ id, class, classList } =
    breakNS


breakUI : InGameState -> Html Action
breakUI state =
    div
        [ id BreakContainer ]
        [ player1Panel state
        , middlePanel state.board
        , player2Panel state
        ]


middlePanel : Board -> Html Action
middlePanel board =
    div
        [ id MiddlePanel ]
        [ div
            [ id BoardPanel ]
            [ Board.view board ]
        , breakBtns
        ]


player1Panel : InGameState -> Html Action
player1Panel state =
    div
        [ class PlayerPanel ]
        [ div
            [ class PlayerName ]
            [ text state.player1.name ]
        , div
            [ class PlayerScore ]
            [ text <| toString state.player1.score ]
        ]


player2Panel : InGameState -> Html Action
player2Panel state =
    div
        [ class PlayerPanel ]
        [ div
            [ class PlayerName ]
            [ text state.player2.name ]
        , div
            [ class PlayerScore ]
            [ text <| toString state.player2.score ]
        ]
