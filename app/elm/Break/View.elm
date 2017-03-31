module Break.View exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Util.Types exposing (..)
import Util.View exposing (..)
import Board.View exposing (board)


breakUI : InGameState -> Html Action
breakUI gameState =
    div
        [ class "break-container"
        , styleList [ flexStyle, columnStyle, (flex 1 0), [ "background" => "#d8d8d8" ] ]
        ]
        [ scoreboard gameState
        , board gameState.board
        ]


scoreboard : InGameState -> Html Action
scoreboard gameState =
    div
        [ class "scoreboard"
        , styleList [ flexStyle, (flex 3 0) ]
        ]
        [ div
            [ styleList [ flexStyle, centerStyle, (flex 2 0) ] ]
            [ scoreBox gameState.player1 ]
        , div
            [ class "scoreboard-center"
            , styleList [ flexStyle, centerStyle, (flex 1 0) ]
            ]
            [ gameBtn gameState ]
        , div
            [ styleList [ flexStyle, centerStyle, (flex 2 0) ] ]
            [ scoreBox gameState.player2 ]
        ]


scoreBox : Player -> Html Action
scoreBox player =
    div
        [ class "scoreboard-left" ]
        [ h3
            [ style [ ( "color", "#1e0812" ) ] ]
            [ text (player.name ++ " score:") ]
        , div
            [ style scoreBoxStyle ]
            [ text <| toString player.score ]
        ]


gameBtn : InGameState -> Html Action
gameBtn state =
    if state.round < 2 then
        div
            [ class "game-start-btn"
            , styleList [ btnStyle, styledBtnStyle ]
            , onClick NextRound
            ]
            [ text "Next Round" ]
    else
        div
            [ class "game-start-btn"
            , styleList [ btnStyle, styledBtnStyle ]
            , onClick NewGame
            ]
            [ text "New Game" ]


scoreBoxStyle : List Attr
scoreBoxStyle =
    [ "color" => "#b61e64"
    , "font-size" => "3em"
    , "font-weight" => "bold"
    ]
