module ScoreTests exposing (allScoreTests)

import Test exposing (..)
import Matrix exposing (set)
import Expect
import Score exposing (score)
import Util.State exposing (makeBoard)
import Util.Types exposing (..)


allScoreTests : Test
allScoreTests =
    describe "testing score"
        [ test "Score on dummy1 - Should equal 16" <|
            \() ->
                Expect.equal 16 <|
                    score dummyFullBoard1
        , test "Score on dummy2 - Should equal 23" <|
            \() ->
                Expect.equal 23 <| score dummyFullBoard2
        ]


{-|
  R O G R V  -  0  -  0 = 0
  O B B V O  -  2  -  2 = 4
  G R R G B  -  6  -  2 = 8
  R O G B V  -  0  -  0 = 0
  B O G V V  -  2  -  2 = 4 => 16
-}
dummyFullBoard1 : Board
dummyFullBoard1 =
    makeBoard
        |> set 0 0 (Cell (Just Red) False 0 0)
        |> set 0 1 (Cell (Just Orange) False 0 1)
        |> set 0 2 (Cell (Just Green) False 0 2)
        |> set 0 3 (Cell (Just Red) False 0 3)
        |> set 0 4 (Cell (Just Violet) False 0 4)
        |> set 1 0 (Cell (Just Orange) False 1 0)
        |> set 1 1 (Cell (Just Blue) False 1 1)
        |> set 1 2 (Cell (Just Blue) False 1 2)
        |> set 1 3 (Cell (Just Violet) False 1 3)
        |> set 1 4 (Cell (Just Orange) False 1 4)
        |> set 2 0 (Cell (Just Green) False 2 0)
        |> set 2 1 (Cell (Just Red) False 2 1)
        |> set 2 2 (Cell (Just Red) False 2 2)
        |> set 2 3 (Cell (Just Green) False 2 3)
        |> set 2 4 (Cell (Just Blue) False 2 4)
        |> set 3 0 (Cell (Just Red) False 3 0)
        |> set 3 1 (Cell (Just Orange) False 3 1)
        |> set 3 2 (Cell (Just Green) False 3 2)
        |> set 3 3 (Cell (Just Blue) False 3 3)
        |> set 3 4 (Cell (Just Violet) False 3 4)
        |> set 4 0 (Cell (Just Blue) False 4 0)
        |> set 4 1 (Cell (Just Orange) False 4 1)
        |> set 4 2 (Cell (Just Green) False 4 2)
        |> set 4 3 (Cell (Just Violet) False 4 3)
        |> set 4 4 (Cell (Just Violet) False 4 4)


{-|
  V O O R G  -  2  -  3 = 5
  B B V R R  -  4  -  2 = 6
  O G B B V  -  2  -  2 = 4
  G G B V O  -  2  -  4 = 6
  O R R V G  -  2  -  0 = 2 => 23
-}
dummyFullBoard2 : Board
dummyFullBoard2 =
    makeBoard
        |> set 0 0 (Cell (Just Violet) False 0 0)
        |> set 0 1 (Cell (Just Orange) False 0 1)
        |> set 0 2 (Cell (Just Orange) False 0 2)
        |> set 0 3 (Cell (Just Red) False 0 3)
        |> set 0 4 (Cell (Just Green) False 0 4)
        |> set 1 0 (Cell (Just Blue) False 1 0)
        |> set 1 1 (Cell (Just Blue) False 1 1)
        |> set 1 2 (Cell (Just Violet) False 1 2)
        |> set 1 3 (Cell (Just Red) False 1 3)
        |> set 1 4 (Cell (Just Red) False 1 4)
        |> set 2 0 (Cell (Just Orange) False 2 0)
        |> set 2 1 (Cell (Just Green) False 2 1)
        |> set 2 2 (Cell (Just Blue) False 2 2)
        |> set 2 3 (Cell (Just Blue) False 2 3)
        |> set 2 4 (Cell (Just Violet) False 2 4)
        |> set 3 0 (Cell (Just Green) False 3 0)
        |> set 3 1 (Cell (Just Green) False 3 1)
        |> set 3 2 (Cell (Just Blue) False 3 2)
        |> set 3 3 (Cell (Just Violet) False 3 3)
        |> set 3 4 (Cell (Just Orange) False 3 4)
        |> set 4 0 (Cell (Just Orange) False 4 0)
        |> set 4 1 (Cell (Just Red) False 4 1)
        |> set 4 2 (Cell (Just Red) False 4 2)
        |> set 4 3 (Cell (Just Violet) False 4 3)
        |> set 4 4 (Cell (Just Green) False 4 4)
