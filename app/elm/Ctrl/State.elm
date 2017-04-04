module Ctrl.State exposing (..)

import Return as R exposing (Return)
import Util.Types exposing (..)
import Ctrl.Types exposing (..)
import Util.Tiles exposing (..)
import Util.State exposing (makeBoard, resetTiles, switchRole, setMsg, ret)
import Util.Lenses exposing (..)
import Game.Message.State as Message


update : Msg -> GameState -> Return Action GameState
update msg state =
    case state of
        Config s ->
            case msg of
                StartGame ->
                    InGame
                        { board = makeBoard
                        , player1 = Player s.player1name Chaos 0
                        , player2 = Player s.player2name Order 0
                        , turn = Chaos
                        , tiles = randomTile <| resetTiles s.initSeed
                        , message = Message.init
                        , nextRound = True
                        }
                        |> ret (setMsg "Place tile in any empty square")

                _ ->
                    R.singleton <| Config s

        InGame s ->
            case msg of
                Reset ->
                    R.singleton <| Config (ConfigState "" "" s.tiles.seed)

                Restart ->
                    InGame
                        { board = makeBoard
                        , player1 = Player s.player1.name Chaos 0
                        , player2 = Player s.player2.name Chaos 0
                        , turn = Chaos
                        , tiles = randomTile <| resetTiles s.tiles.seed
                        , message = Message.init
                        , nextRound = True
                        }
                        |> ret (setMsg "Place tile in any empty square")

                _ ->
                    R.singleton <| InGame s

        OutGame s ->
            case msg of
                Reset ->
                    R.singleton <| Config (ConfigState "" "" s.tiles.seed)

                NextRound ->
                    { s
                        | nextRound = False
                        , turn = Chaos
                    }
                        |> boardL.set makeBoard
                        |> tilesL.set (randomTile <| resetTiles <| seedL.get s)
                        |> InGame
                        |> R.singleton

                _ ->
                    R.singleton <| OutGame s
