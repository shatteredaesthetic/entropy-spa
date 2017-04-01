module ScoreTests exposing (allScoreTests)

import Test exposing (..)
import Expect
import TestUtil exposing (..)
import Score exposing (score)


allScoreTests : Test
allScoreTests =
    describe "testing score"
        [ test "Score on dummy1 - Should equal 16" <|
            \() ->
                Expect.equal 16 <|
                    score mockFullBoard1
        , test "Score on dummy2 - Should equal 23" <|
            \() ->
                Expect.equal 23 <| score mockFullBoard2
        ]
