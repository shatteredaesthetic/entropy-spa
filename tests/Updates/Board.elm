module Updates.Board exposing (allBoardUpdateTests)

import Test exposing (..)
import Expect
import Board.State exposing (..)
import Util.Types exposing (..)


allBoardUpdateTests : Test
allBoardUpdateTests =
    describe "Board Update function"
        [ updateChaosTests
        , orderFirstMoveTests
        , orderSecondMoveTests
        ]


updateChaosTests : Test
updateChaosTests =
    describe "Tests for updateChaos"
        [ test "" <|
            \() ->
                Expect.equal 1 1
        ]


orderFirstMoveTests : Test
orderFirstMoveTests =
    describe "Tests for orderFirstMove"
        []


orderSecondMoveTests : Test
orderSecondMoveTests =
    describe "Tests for orderSecondMove"
        []
