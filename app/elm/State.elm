module State exposing (..)

import Return as R exposing (Return)
import Util.Types exposing (..)
import Util.Tiles exposing (..)
import Util.State exposing (makeBoard, resetTiles, switchRole, setMsg, ret)
import Util.Lenses exposing (..)
import Board.State exposing (updateGame)
import Message.State as Message


updateState : Action -> GameState -> Return Action GameState
updateState action state =
    case state of
        Config cfg ->
            updateConfig action cfg

        InGame state ->
            updateGame action state

        OutGame state ->
            updateBreak action state


updateBreak : Action -> InGameState -> Return Action GameState
updateBreak action state =
    case action of
        NextRound ->
            { state
                | nextRound = False
                , turn = Chaos
            }
                |> boardL.set makeBoard
                |> tilesL.set (resetTiles <| iSeedL.get state)
                |> InGame
                |> R.singleton

        NewGame ->
            R.singleton <| Config (ConfigState "" "" state.initSeed)

        _ ->
            R.singleton <| OutGame state


updateConfig : Action -> ConfigState -> Return Action GameState
updateConfig action cfg =
    case action of
        SetPlayer1 str ->
            R.singleton <| Config { cfg | player1name = str }

        SetPlayer2 str ->
            R.singleton <| Config { cfg | player2name = str }

        StartGame ->
            InGame
                { board = makeBoard
                , player1 = Player cfg.player1name Chaos 0
                , player2 = Player cfg.player2name Order 0
                , turn = Chaos
                , tiles = randomTile <| resetTiles cfg.initSeed
                , message = Message.init
                , nextRound = True
                , initSeed = cfg.initSeed
                }
                |> ret (setMsg "Place tile in any empty square")

        _ ->
            R.singleton <| Config cfg
