module Util.Types exposing (..)

import Matrix exposing (Matrix)
import Random exposing (Seed)
import Dict exposing (Dict)
import Http


type GameState
    = Config ConfigState
    | InGame InGameState
    | OutGame InGameState


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
    , round : Int
    , message : Cont
    , initSeed : Seed
    }


type Cont
    = DoCont String
    | NoCont String


type Message
    = Empty
    | Show String


type alias Board =
    Matrix Cell


type alias Cell =
    { colour : Maybe Colour
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


type alias TileState =
    { current : Maybe Colour
    , ref : Dict String Int
    , seed : Seed
    }


type alias ScoreReturn =
    { score : Int
    , round : Int
    }


type Action
    = StartGame
    | NextRound
    | NewGame
    | Choose Int Int
    | MsgIn Message
    | MsgOut Message
    | NoMsg
    | SetPlayer1 String
    | SetPlayer2 String
    | ScoreChaos (Result Http.Error ScoreReturn)
