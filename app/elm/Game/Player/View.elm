module Game.Player.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Player.Styles exposing (..)
import Ctrl.View exposing (gameBtns)


{ id, class, className } =
    playerNS


player1Header : InGameState -> Html Action
player1Header state =
    div
        [ id P1Container
        , styleList
        ]
        [ div
            [ class TopContainer ]
            [ div
                [ id P1Token ]
                [ playerToken state.player1 ]
            , div
                [ class NameContainer ]
                [ div
                    [ class PlayerName ]
                    [ text state.player1.name ]
                ]
            , div
                [ class ScoreContainer ]
                [ div
                    [ class PlayerScore ]
                    [ text <| toString state.player1.score ]
                ]
            ]
        , div
            [ class BottomContainer ]
            [ div
                [ id SelectedTile ]
                [ div
                    [ style <| currentTileStyle state.tiles.current ]
                    []
                ]
            ]
        ]


player2Header : InGameState -> Html Action
player2Header state =
    div
        [ id P2Container ]
        [ div
            [ class TopContainer ]
            [ div
                [ id P2Token ]
                [ playerToken state.player2 ]
            , div
                [ class NameContainer ]
                [ div
                    [ class PlayerName ]
                    [ text state.player2.name ]
                ]
            , div
                [ class ScoreContainer
                , styleList [ flexStyle ]
                ]
                [ div
                    [ class PlayerScore ]
                    [ text <| toString state.player2.score ]
                ]
            ]
        , div
            [ class BottomContainer ]
            [ gameBtns ]
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
            [ class TokenContainer
            , styleList
            ]
            [ div
                [ class TokenInner ]
                [ div
                    [ class PlayerToken ]
                    [ text token ]
                ]
            ]
