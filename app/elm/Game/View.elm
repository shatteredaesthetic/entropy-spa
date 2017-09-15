module Game.View exposing (gameUI)

import Html exposing (..)
import Util.Types exposing (..)
import Game.Player.View exposing (..)
import Game.Message.View as Message
import Game.Board.View as Board
import Styled exposing (..)


gameUI : InGameState -> Html Action
gameUI state =
    gameUICont []
        [ p1Header state
        , gameView state
        , p2Header state
        ]


gameView : InGameState -> Html Action
gameView { board, message } =
    gameViewCont []
        [ Board.view board
        , Message.view message
        ]


gameUICont : StyledComponent
gameUICont =
    styled div
        [ display flex_
        , width (percent 100)
        , height (percent 100)
        ]


gameViewCont : StyledComponent
gameViewCont =
    styled div
        [ display flex_
        , flexDirection column
        , justifyContent spaceAround
        ]
