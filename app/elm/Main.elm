module Main exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import Break.View exposing (breakUI)
import Config.State exposing (updateConfig)
import Config.View exposing (configUI)
import Ctrl.State as Btn
import Game.Board.State exposing (updateGame)
import Game.View exposing (gameUI)
import Util.Types exposing (..)
import Util.View exposing (styleList, outerContainer, flexStyle, (=>))


type alias Flags =
    { randSeed : Int }


init : Flags -> Return Action GameState
init { randSeed } =
    initialSeed randSeed
        |> ConfigState "" ""
        |> Config
        |> R.singleton


view : GameState -> Html Action
view gameState =
    let
        content =
            case gameState of
                Config cfg ->
                    configUI cfg

                InGame inGameState ->
                    gameUI inGameState

                OutGame inGameState ->
                    breakUI inGameState
    in
        div
            [ class "container"
            , styleList [ flexStyle, outerContainer, [ "border" => "1px solid red" ] ]
            ]
            [ content ]


update : Action -> GameState -> Return Action GameState
update action state =
    case state of
        Config cfg ->
            updateConfig action cfg

        InGame s ->
            updateGame action s

        OutGame s ->
            case action of
                Btn btnMsg ->
                    Btn.update btnMsg state

                _ ->
                    R.singleton state


main : Program Flags GameState Action
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \state -> Sub.none
        }
