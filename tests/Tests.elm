module Tests exposing (all)

import Test exposing (..)
import ScoreTests exposing (allScoreTests)
import Updates.Board exposing (allBoardUpdateTests)
import Updates.State exposing (allStateUpdateTests)
import Doc.Tests as Doc


all : Test
all =
    describe "Sample Test Suite"
        [ allScoreTests
        , allBoardUpdateTests
        , allStateUpdateTests
        , Doc.all
        ]
