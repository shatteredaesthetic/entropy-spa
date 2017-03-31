module Updates.State exposing (allStateUpdateTests)

import Test exposing (..)
import Expect
import State exposing (..)
import Util.Types exposing (..)


allStateUpdateTests : Test
allStateUpdateTests =
    describe "State update functions (minus InGame)"
        [ updateConfigTests
        , updateBreakTests
        ]


updateConfigTests : Test
updateConfigTests =
    describe "Tests for updateConfig"
        [ test "" <|
            \() ->
                Expect.equal 1 1
        ]


updateBreakTests : Test
updateBreakTests =
    describe "Tests for updateBreak"
        []
