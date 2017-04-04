module Game.Player.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, class)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Player.Styles exposing (..)


player1Header : InGameState -> Html Action
player1Header state =
    div
        [ class "p1-container"
        , styleList [ flexStyle, columnStyle, flex 1 0 ]
        ]
        [ div
            [ class "player-top-container"
            , styleList [ flexStyle, columnStyle, aiStyle "flex-start", flex 3 0 ]
            ]
            [ div
                [ class "player-token"
                , styleList [ flexStyle, aiStyle "flex-end" ]
                ]
                [ playerToken state.player1 ]
            , div
                [ class "name-container" ]
                [ div
                    [ class "player-name"
                    , styleList [ aiStyle "center", txtCol "#fafafa" ]
                    ]
                    [ text state.player1.name ]
                ]
            , div
                [ class "score-container" ]
                [ div
                    [ class "player-score"
                    , styleList [ flexStyle, centerStyle, txtCol "#fafafa" ]
                    ]
                    [ text <| toString state.player1.score ]
                ]
            ]
        , div
            [ class "player-bottom-container"
            , styleList [ flexStyle, aiStyle "flex-end", flex 1 0 ]
            ]
            [ div
                [ class "selected-tile"
                , styleList [ flexStyle, centerStyle ]
                ]
                [ div
                    [ style <| currentTileStyle state ]
                    []
                ]
            ]
        ]


player2Header : InGameState -> Html Action
player2Header state =
    div
        [ class "p2-container"
        , styleList [ flexStyle, columnStyle, flex 1 0 ]
        ]
        [ div
            [ class "player-top-container"
            , styleList [ flexStyle, columnStyle, aiStyle "flex-start", flex 3 0 ]
            ]
            [ div
                [ class "player-token"
                , styleList [ flexStyle, aiStyle "flex-start" ]
                ]
                [ playerToken state.player2 ]
            , div
                [ class "name-container" ]
                [ div
                    [ class "player-name"
                    , styleList [ aiStyle "flex-end", txtCol "#fafafa" ]
                    ]
                    [ text state.player2.name ]
                ]
            , div
                [ class "score-container"
                , styleList [ flexStyle ]
                ]
                [ div
                    [ class "player-score"
                    , styleList [ flexStyle, centerStyle, txtCol "#fafafa" ]
                    ]
                    [ text <| toString state.player2.score ]
                ]
            ]
        , div
            [ class "player-bottom-container"
            , styleList [ flexStyle, aiStyle "flex-end", flex 1 0 ]
            ]
            [ div
                [ class "btn-container" ]
                [ div
                    [ class "restart-btn" ]
                    [ text "Restart" ]
                , div
                    [ class "reset-btn" ]
                    [ text "Reset" ]
                ]
            ]
        ]


playerToken : Player -> Html Action
playerToken player =
    let
        token =
            case player.role of
                Chaos ->
                    "C"

                Order ->
                    "O"
    in
        div
            [ class "token-container"
            , styleList [ flexStyle, centerStyle ]
            ]
            [ div
                [ class "token-inner-container"
                , styleList [ flexStyle, centerStyle, innerStyle ]
                ]
                [ div
                    [ class "player-token"
                    , styleList [ tokenStyle, flex 1 0 ]
                    ]
                    [ text token ]
                ]
            ]
