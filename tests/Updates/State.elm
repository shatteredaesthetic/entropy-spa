module Updates.State exposing (allStateUpdateTests)

import Test exposing (..)
import Expect
import TestUtil exposing (..)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import Config.State exposing (..)
import Util.Types exposing (..)
import Ctrl.Types exposing (..)


allStateUpdateTests : Test
allStateUpdateTests =
    describe "State update functions (minus InGame)"
        [ updateConfigTests ]


updateConfigTests : Test
updateConfigTests =
    describe "Tests for updateConfig"
        [ test "sets Player 1 name" <|
            \() ->
                Expect.equal mockConfigP1 <|
                    updateConfig (SetPlayer1 "1") mockEmptyConfig
        , test "sets Player 2 name" <|
            \() ->
                Expect.equal mockConfigP2 <|
                    updateConfig (SetPlayer2 "2") mockEmptyConfig
        , test "Starts game with fresh InGameState" <|
            \() ->
                Expect.equal mockStartState <|
                    Tuple.first <|
                        updateConfig (Btn StartGame) mockFullConfig
        ]


mockConfigP1 : Return Action GameState
mockConfigP1 =
    R.singleton <|
        Config
            { player1name = "1"
            , player2name = ""
            , initSeed = initialSeed 5543
            }


mockConfigP2 : Return Action GameState
mockConfigP2 =
    R.singleton <|
        Config
            { player1name = ""
            , player2name = "2"
            , initSeed = initialSeed 5543
            }


mockStartState : GameState
mockStartState =
    InGame mockInGameEmptyState
