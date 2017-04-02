module LensTests exposing (..)

import Test exposing (..)
import Expect
import TestUtil exposing (..)
import Util.Types exposing (..)
import Util.Lenses exposing (..)


allLensTests : Test
allLensTests =
    describe "Testing Lens functions"
        [ p1ScoreLTests
          --, p2ScoreLTests
        ]


p1ScoreLTests : Test
p1ScoreLTests =
    let
        state =
            case mockNewRoundState of
                InGame st ->
                    st

                _ ->
                    mockInGameEmptyState

        player1 =
            state.player1

        newPlyr =
            { player1 | score = 16 }

        newState =
            { state | player1 = newPlyr }
    in
        describe "Tests for p1ScoreL"
            [ test "grabs score from state" <|
                \() ->
                    Expect.equal 23 <|
                        p1ScoreL.get state
            , test "sets score in state" <|
                \() ->
                    Expect.equal newState <|
                        p1ScoreL.set 16 state
            ]



{-
   p2ScoreLTests : Test
   p2ScoreLTests =
       let
           state =
               case mockNewRoundState of
                   InGame st ->
                       st

                   _ ->
                       mockInGameEmptyState

           player2 =
               state.player2

           newPlyr =
               { player2 | score = 16 }

           newState =
               { state | player2 = player2 }
       in
           describe "Tests for p1ScoreL"
               [ test "grabs score from state" <|
                   \() ->
                       Expect.equal 0 <|
                           p2ScoreL.get state
               , test "sets score in state" <|
                   \() ->
                       Expect.equal newState <|
                           p2ScoreL.set 16 state
               ]
-}
