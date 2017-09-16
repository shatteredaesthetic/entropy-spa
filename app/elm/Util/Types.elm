module Util.Types exposing (..)

import Matrix exposing (Matrix)
import Random exposing (Seed)
import Dict exposing (Dict)
import Game.Message.Types as Message
import Ctrl.Types as Ctrl
import VirtualDom exposing (Property, Node)


type GameState
    = Config ConfigState
    | InGame InGameState
    | Break InGameState
    | GameOver InGameState


type alias ConfigState =
    { player1name : String
    , player2name : String
    , initSeed : Seed
    }


type alias InGameState =
    { board : Board
    , player1 : Player
    , player2 : Player
    , turn : Role
    , tiles : TileState
    , nextRound : Bool
    , message : Message.Model
    }


type alias Board =
    Matrix Cell


type alias Cell =
    { colour : Colour
    , highlight : Bool
    , x : Int
    , y : Int
    }


type alias Player =
    { name : String
    , role : Role
    , score : Int
    }


type Role
    = Chaos
    | Order


type Colour
    = Red
    | Orange
    | Green
    | Blue
    | Violet
    | NoTile


type alias TileState =
    { current : Cell
    , ref : Dict String Int
    , seed : Seed
    }


type alias ScoreReturn =
    { score : Int
    , round : Int
    }


type Action
    = Choose Int Int
    | Btn Ctrl.Msg
    | Msg Message.Msg
    | SetPlayer1 String
    | SetPlayer2 String


type alias StyledComponent =
    List (Property Action) -> List (Node Action) -> Node Action
