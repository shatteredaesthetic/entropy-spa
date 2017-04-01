module Updates.State exposing (allStateUpdateTests)

import Test exposing (..)
import Expect
import TestUtil exposing (..)
import Random exposing (initialSeed)
import Return as R exposing (Return)
import State exposing (..)
import Util.Types exposing (..)


allStateUpdateTests : Test
allStateUpdateTests =
    describe "State update functions (minus InGame)"
        [ updateConfigTests
        , updateBreakTests
        , updateStateTests
        ]


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
          {- }, test "Starts game with fresh InGameState" <|
             \() ->
                 Expect.equal mockStartState <|
                     updateConfig StartGame mockFullConfig
          -}
        ]


updateBreakTests : Test
updateBreakTests =
    describe "Tests for updateBreak"
        [ test "NewGame sets up an empth Config" <|
            \() ->
                Expect.equal (R.singleton <| Config mockEmptyConfig) <|
                    updateBreak NewGame mockInGameEmptyState
        ]


updateStateTests : Test
updateStateTests =
    describe "Tests for updateState"
        [ test "NewGame from updateBreak" <|
            \() ->
                Expect.equal (R.singleton <| Config mockEmptyConfig) <|
                    updateState NewGame (OutGame mockInGameEmptyState)
        , test "SetPlayer1 from updateConfig" <|
            \() ->
                Expect.equal mockConfigP1 <|
                    updateState (SetPlayer1 "1") (Config mockEmptyConfig)
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


mockStartState : Return Action GameState
mockStartState =
    R.singleton <| InGame mockInGameEmptyState
