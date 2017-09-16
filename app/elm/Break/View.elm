module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Styled exposing (..)
import Util.Types exposing (..)
import Game.Board.View as Board
import Ctrl.View exposing (breakBtns)
import Util.View exposing (..)


breakUI : InGameState -> Html Action
breakUI state =
    breakWrap []
        [ sidePanel state.player1
        , middlePanel state.board
        , sidePanel state.player2
        ]


middlePanel : Board -> Html Action
middlePanel board =
    middleWrap []
        [ breakBd [] [ Board.view board ]
        , breakBtns
        ]


middleWrap : StyledComponent
middleWrap =
    styled columnWrap [ flex (int 3) (int 0) (percent 60) ]


breakWrap : StyledComponent
breakWrap =
    styled stretchWrap [ display flex_ ]


breakBd : StyledComponent
breakBd =
    styled centerWrap [ height (percent 70) ]
