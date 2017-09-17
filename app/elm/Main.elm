module Main exposing (..)

import Html exposing (Html, div)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import Styled exposing (..)
import Break.View exposing (breakUI)
import Config.State exposing (updateConfig)
import Config.View exposing (cfgUI)
import Ctrl.State as Btn
import Game.Board.State exposing (updateGame)
import Game.View exposing (gameUI)
import Result.View exposing (resultUI)
import Util.Types exposing (..)


type alias Flags =
    { randSeed : Int }


init : Flags -> Return Action GameState
init { randSeed } =
    initialSeed randSeed
        |> ConfigState "" ""
        |> Config
        |> R.singleton


viewCont : StyledComponent
viewCont =
    styled div
        [ display flex_
        , width (vw 100)
        , height (vh 100)
        , backgroundColor (hex "224f75")
        ]


view : GameState -> Html Action
view gameState =
    let
        content =
            case gameState of
                Config cfg ->
                    cfgUI cfg

                InGame inGameState ->
                    gameUI inGameState

                Break inGameState ->
                    breakUI inGameState

                GameOver inGameState ->
                    resultUI inGameState
    in
        viewCont [] [ content ]


update : Action -> GameState -> Return Action GameState
update action state =
    case state of
        Config cfg ->
            updateConfig action cfg

        InGame s ->
            updateGame action s

        Break s ->
            case action of
                Btn btnMsg ->
                    Btn.update btnMsg state

                _ ->
                    R.singleton state

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
