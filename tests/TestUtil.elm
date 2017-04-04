module TestUtil exposing (..)

import Random exposing (initialSeed)
import Matrix exposing (set)
import Util.Types exposing (..)
import Util.State exposing (..)
import Util.Tiles exposing (randomTile)
import Util.Lenses exposing (..)
import Game.Message.State as Message
import Random exposing (Seed)
import Dict


mockEmptyConfig : ConfigState
mockEmptyConfig =
    { player1name = ""
    , player2name = ""
    , initSeed = initialSeed 5543
    }


mockFullConfig : ConfigState
mockFullConfig =
    { player1name = "1"
    , player2name = "2"
    , initSeed = initialSeed 5543
    }


mockInGameEmptyState : InGameState
mockInGameEmptyState =
    { board = makeBoard
    , player1 = Player "1" Chaos 0
    , player2 = Player "2" Order 0
    , turn = Chaos
    , tiles = randomTile <| resetTiles <| initialSeed 5543
    , nextRound = True
    , message = Message.init
    }


mockInGameFullState : InGameState
mockInGameFullState =
    { board = mockFullBoard1
    , player1 = Player "1" Chaos 0
    , player2 = Player "2" Order 0
    , turn = Chaos
    , tiles = randomTile <| resetTiles <| initialSeed 5543
    , nextRound = True
    , message = Message.init
    }


{-|
  R O G R V  -  0  -  0 = 0
  O B B V O  -  2  -  2 = 4
  G R R G B  -  6  -  2 = 8
  R O G B V  -  0  -  0 = 0
  B O G V V  -  2  -  2 = 4 => 16
-}
mockFullBoard1 : Board
mockFullBoard1 =
    makeBoard
        |> set 0 0 (Cell Red False 0 0)
        |> set 0 1 (Cell Orange False 0 1)
        |> set 0 2 (Cell Green False 0 2)
        |> set 0 3 (Cell Red False 0 3)
        |> set 0 4 (Cell Violet False 0 4)
        |> set 1 0 (Cell Orange False 1 0)
        |> set 1 1 (Cell Blue False 1 1)
        |> set 1 2 (Cell Blue False 1 2)
        |> set 1 3 (Cell Violet False 1 3)
        |> set 1 4 (Cell Orange False 1 4)
        |> set 2 0 (Cell Green False 2 0)
        |> set 2 1 (Cell Red False 2 1)
        |> set 2 2 (Cell Red False 2 2)
        |> set 2 3 (Cell Green False 2 3)
        |> set 2 4 (Cell Blue False 2 4)
        |> set 3 0 (Cell Red False 3 0)
        |> set 3 1 (Cell Orange False 3 1)
        |> set 3 2 (Cell Green False 3 2)
        |> set 3 3 (Cell Blue False 3 3)
        |> set 3 4 (Cell Violet False 3 4)
        |> set 4 0 (Cell Blue False 4 0)
        |> set 4 1 (Cell Orange False 4 1)
        |> set 4 2 (Cell Green False 4 2)
        |> set 4 3 (Cell Violet False 4 3)
        |> set 4 4 (Cell Violet False 4 4)


{-|
  V O O R G  -  2  -  3 = 5
  B B V R R  -  4  -  2 = 6
  O G B B V  -  2  -  2 = 4
  G G B V O  -  2  -  4 = 6
  O R R V G  -  2  -  0 = 2 => 23
-}
mockFullBoard2 : Board
mockFullBoard2 =
    makeBoard
        |> set 0 0 (Cell Violet False 0 0)
        |> set 0 1 (Cell Orange False 0 1)
        |> set 0 2 (Cell Orange False 0 2)
        |> set 0 3 (Cell Red False 0 3)
        |> set 0 4 (Cell Green False 0 4)
        |> set 1 0 (Cell Blue False 1 0)
        |> set 1 1 (Cell Blue False 1 1)
        |> set 1 2 (Cell Violet False 1 2)
        |> set 1 3 (Cell Red False 1 3)
        |> set 1 4 (Cell Red False 1 4)
        |> set 2 0 (Cell Orange False 2 0)
        |> set 2 1 (Cell Green False 2 1)
        |> set 2 2 (Cell Blue False 2 2)
        |> set 2 3 (Cell Blue False 2 3)
        |> set 2 4 (Cell Violet False 2 4)
        |> set 3 0 (Cell Green False 3 0)
        |> set 3 1 (Cell Green False 3 1)
        |> set 3 2 (Cell Blue False 3 2)
        |> set 3 3 (Cell Violet False 3 3)
        |> set 3 4 (Cell Orange False 3 4)
        |> set 4 0 (Cell Orange False 4 0)
        |> set 4 1 (Cell Red False 4 1)
        |> set 4 2 (Cell Red False 4 2)
        |> set 4 3 (Cell Violet False 4 3)
        |> set 4 4 (Cell Green False 4 4)


mockOneMoveBoard : Board
mockOneMoveBoard =
    makeBoard
        |> set 0 0 (Cell Violet False 0 0)
        |> set 0 1 (Cell NoTile False 0 1)
        |> set 0 2 (Cell Orange False 0 2)
        |> set 0 3 (Cell Red False 0 3)
        |> set 0 4 (Cell Green False 0 4)
        |> set 1 0 (Cell Blue False 1 0)
        |> set 1 1 (Cell Blue False 1 1)
        |> set 1 2 (Cell Violet False 1 2)
        |> set 1 3 (Cell Red False 1 3)
        |> set 1 4 (Cell Red False 1 4)
        |> set 2 0 (Cell Orange False 2 0)
        |> set 2 1 (Cell Green False 2 1)
        |> set 2 2 (Cell Blue False 2 2)
        |> set 2 3 (Cell Blue False 2 3)
        |> set 2 4 (Cell Violet False 2 4)
        |> set 3 0 (Cell Green False 3 0)
        |> set 3 1 (Cell Green False 3 1)
        |> set 3 2 (Cell Blue False 3 2)
        |> set 3 3 (Cell Violet False 3 3)
        |> set 3 4 (Cell Orange False 3 4)
        |> set 4 0 (Cell Orange False 4 0)
        |> set 4 1 (Cell Red False 4 1)
        |> set 4 2 (Cell Red False 4 2)
        |> set 4 3 (Cell Violet False 4 3)
        |> set 4 4 (Cell Green False 4 4)


mockNewRoundState : GameState
mockNewRoundState =
    let
        m =
            { board = makeBoard
            , player1 = Player "1" Order 23
            , player2 = Player "2" Chaos 0
            , turn = Chaos
            , tiles = resetTiles <| initialSeed 5543
            , nextRound = False
            , message = Message.init
            }

        newTiles =
            randomTile m.tiles
    in
        m
            |> tilesL.set (TileState NoTile (Dict.fromList [ ( "red", 1 ) ]) newTiles.seed)
            |> InGame


mockBreakState : GameState
mockBreakState =
    { board = mockFullBoard2
    , player1 = Player "1" Order 0
    , player2 = Player "2" Chaos 23
    , turn = Chaos
    , tiles = resetTiles <| initialSeed 5544
    , nextRound = True
    , message = Message.init
    }
        |> tilesL.set
            (TileState NoTile (Dict.fromList [ ( "orange", 5 ), ( "blue", 5 ), ( "green", 5 ), ( "violet", 5 ), ( "red", 5 ) ]) (initialSeed 5544))
        |> OutGame


mockInGameOneMoveState : InGameState
mockInGameOneMoveState =
    { board = mockOneMoveBoard
    , player1 = Player "1" Chaos 0
    , player2 = Player "2" Order 0
    , turn = Chaos
    , tiles =
        TileState
            Orange
            (Dict.fromList [ ( "orange", 5 ), ( "blue", 5 ), ( "green", 5 ), ( "violet", 5 ), ( "red", 5 ) ])
            (initialSeed 5544)
    , nextRound = True
    , message = Message.init
    }


mockNewBreakState : GameState
mockNewBreakState =
    { board = mockFullBoard2
    , player1 = Player "1" Order 23
    , player2 = Player "2" Chaos 0
    , turn = Chaos
    , tiles = resetTiles <| initialSeed 5544
    , nextRound = True
    , message = Message.init
    }
        |> tilesL.set
            (TileState NoTile (Dict.fromList [ ( "orange", 5 ), ( "blue", 5 ), ( "green", 5 ), ( "violet", 5 ), ( "red", 5 ) ]) (initialSeed 22183761640692))
        |> OutGame
