module Main exposing (..)

import Html exposing (Html)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import Util.Types exposing (..)
import State exposing (updateState)
import Board.View exposing (gameView)
import Config.View exposing (configUI)
import Break.View exposing (breakUI)


type alias Flags =
    { randSeed : Int }


init : Flags -> Return Action GameState
init { randSeed } =
    let
        state =
            ConfigState "" "" <| initialSeed randSeed
    in
        R.singleton <| Config state


view : GameState -> Html Action
view gameState =
    case gameState of
        Config cfg ->
            configUI cfg

        InGame inGameState ->
            gameView inGameState

        OutGame inGameState ->
            breakUI inGameState


update : Action -> GameState -> ( GameState, Cmd Action )
update action gameState =
    updateState action gameState


main : Program Flags GameState Action
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \state -> Sub.none
        }
