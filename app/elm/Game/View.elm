module Game.View exposing (gameUI)

import Html exposing (..)
import Styled exposing (..)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Player.View exposing (..)
import Game.Message.View as Message
import Game.Board.View as Board


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
    styled stretchWrap [ display flex_ ]


gameViewCont : StyledComponent
gameViewCont =
    styled columnWrap [ justifyContent spaceAround ]
