module Game.View exposing (gameUI)

import Html exposing (..)
import Html.Attributes exposing (class)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Player.View exposing (..)
import Game.Message.View as Message
import Game.Board.View as Board


gameUI : InGameState -> Html Action
gameUI state =
    div
        [ class "game-container"
        , styleList [ flexStyle, stretchStyle ]
        ]
        [ player1Header state
        , gameView state
        , player2Header state
        ]


gameView : InGameState -> Html Action
gameView state =
    div
        [ class "game-middle-panel"
        , styleList [ flexStyle, columnStyle, jcStyle "space-around" ]
        ]
        [ Board.view state.board
        , Message.view state.message
        ]
