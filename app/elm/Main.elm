module Main exposing (..)

import Html exposing (Html, div)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import Break.View exposing (breakUI)
import Config.State exposing (updateConfig)
import Config.View exposing (cfgUI)
import Ctrl.State as Btn
import Game.Board.State exposing (updateGame)
import Game.View exposing (gameUI)
import Util.Types exposing (..)
import Styled exposing (..)


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
        , backgroundColor (hex "1e0812")
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

                OutGame inGameState ->
                    breakUI inGameState
    in
        viewCont [] [ content ]


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



-- view : GameState -> Html Action
-- view gameState =
--     let
--         content =
--             case gameState of
--                 Config cfg ->
--                     cfgUI cfg
--
--                 InGame inGameState ->
--                     gameUI inGameState
--
--                 OutGame inGameState ->
--                     breakUI inGameState
--     in
--         div
--             [ class "container"
--             , styleList [ flexStyle, outerContainer, [ "border" => "1px solid red" ] ]
--             ]
--             [ content ]
