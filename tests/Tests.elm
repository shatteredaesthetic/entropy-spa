module Tests exposing (all)

import Test exposing (..)
import ScoreTests exposing (allScoreTests)
import Updates.Board exposing (allBoardUpdateTests)
import Updates.State exposing (allStateUpdateTests)
import LensTests exposing (allLensTests)
import Doc.Tests as Doc


all : Test
all =
    describe "Sample Test Suite"
        [ allScoreTests
        , allBoardUpdateTests
        , allStateUpdateTests
        , allLensTests
        , Doc.all
        ]
