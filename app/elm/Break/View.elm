module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (id, style)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Board.View as Board
import Ctrl.View exposing (breakBtns)


breakUI : InGameState -> Html Action
breakUI state =
    div
        [ id "break-container"
        , styleList [ flexStyle, stretchStyle ]
        ]
        [ player1Panel state
        , middlePanel state.board
        , player2Panel state
        ]


middlePanel : Board -> Html Action
middlePanel board =
    div
        [ id "middle-panel"
        , styleList [ flexStyle, columnStyle ]
        ]
        [ div
            [ id "board-panel"
            , styleList [ flexStyle, centerStyle, ht "70%" ]
            ]
            [ Board.view board ]
        , breakBtns
        ]


player1Panel : InGameState -> Html Action
player1Panel state =
    div
        [ id "player-panel"
        , styleList [ flexStyle, columnStyle, wd "25%" ]
        ]
        [ div
            [ id "player-name"
            , styleList [ flexStyle, aiStyle "flex-end" ]
            ]
            [ text state.player1.name ]
        , div
            [ id "player-score"
            , styleList [ flexStyle, centerStyle ]
            ]
            [ text <| toString state.player1.score ]
        ]


player2Panel : InGameState -> Html Action
player2Panel state =
    div
        [ id "player-panel"
        , styleList [ flexStyle, columnStyle, wd "25%" ]
        ]
        [ div
            [ id "player-name"
            , styleList [ flexStyle, aiStyle "flex-start" ]
            ]
            [ text state.player2.name ]
        , div
            [ id "player-score"
            , styleList [ flexStyle, centerStyle ]
            ]
            [ text <| toString state.player2.score ]
        ]
