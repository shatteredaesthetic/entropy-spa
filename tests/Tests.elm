module Tests exposing (all)

import Test exposing (..)
import ScoreTests exposing (allScoreTests)
import Doc.Tests as Doc


all : Test
all =
    describe "Sample Test Suite"
        [ allScoreTests
        , Doc.all
        ]
