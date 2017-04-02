module Updates.Board exposing (allBoardUpdateTests)

import Test exposing (..)
import Expect
import TestUtil exposing (..)
import Return as R
import Random exposing (initialSeed)
import Dict
import Matrix exposing (set)
import Monocle.Lens exposing (modify)
import Board.State exposing (..)
import Util.State exposing (..)
import Util.Types exposing (..)
import Util.Lenses exposing (..)
import Message.State as Message
import Util.Tiles exposing (randomTile)


allBoardUpdateTests : Test
allBoardUpdateTests =
    describe "Board Update function"
        [ updateChaosTests
        , orderFirstMoveTests
        , orderSecondMoveTests
        ]


updateChaosTests : Test
updateChaosTests =
    describe "Tests for updateChaos (and updateGame)" <|
        let
            newState =
                updateChaos 0 1 mockInGameEmptyState

            model =
                Tuple.first newState

            ( model_, _ ) =
                case model of
                    InGame m ->
                        updateChaos 0 1 m

                    _ ->
                        model ! []
        in
            [ test "updateChaos renders a correct move" <|
                \() ->
                    Expect.equal mockInGameChaosMoveState model
            , test "updateChaos does not render an incorrect move" <|
                \() ->
                    Expect.equal model model_
            , test "updateOrder works as expected (from updateChaos)" <|
                \() ->
                    Expect.equal mockInGameChaosMoveState <|
                        Tuple.first <|
                            updateGame (Choose 0 1) mockInGameEmptyState
            , test "renders to OutGame state when board is full" <|
                \() ->
                    Expect.equal mockBreakState <|
                        Tuple.first <|
                            updateChaos 0 1 mockInGameOneMoveState
            ]


orderFirstMoveTests : Test
orderFirstMoveTests =
    describe "Tests for orderFirstMove (and updateOrder, updateGame)" <|
        let
            firstState =
                updateChaos 0 1 mockInGameEmptyState

            newState =
                case Tuple.first firstState of
                    InGame st ->
                        st

                    _ ->
                        mockInGameEmptyState

            m =
                orderFirstMove 0 1 newState

            model =
                Tuple.first m

            ( badState, _ ) =
                case mockInGameChaosMoveState of
                    InGame st ->
                        orderFirstMove 1 0 st

                    _ ->
                        R.singleton <| InGame mockInGameEmptyState
        in
            [ test "updateOrderFirstMove renders the first move correctly" <|
                \() ->
                    Expect.equal mockInGameOrderFirstMoveState model
            , test "updateOderFirstMove won't render illegal moves" <|
                \() ->
                    Expect.equal badState <| Tuple.first firstState
            , test "updateOrder works as expected (from orderFirstMove)" <|
                \() ->
                    Expect.equal mockInGameOrderFirstMoveState <|
                        Tuple.first <|
                            updateOrder 0 1 <|
                                newState
            , test "updateGame works as expected (from orderFirstMove)" <|
                \() ->
                    Expect.equal mockInGameOrderFirstMoveState <|
                        Tuple.first <|
                            updateGame (Choose 0 1) newState
            ]


orderSecondMoveTests : Test
orderSecondMoveTests =
    describe "Tests for orderSecondMove (and updateOrder, updateGame)" <|
        let
            firstState =
                updateChaos 0 1 mockInGameEmptyState
                    |> Tuple.first

            secondState =
                case firstState of
                    InGame st ->
                        orderFirstMove 0 1 st
                            |> Tuple.first

                    _ ->
                        InGame mockInGameEmptyState

            newState =
                case secondState of
                    InGame st ->
                        st

                    _ ->
                        mockInGameEmptyState

            m =
                orderSecondMove 0 0 Red newState

            model =
                Tuple.first m

            ( badState, _ ) =
                case secondState of
                    InGame st ->
                        orderSecondMove 1 0 Red st

                    _ ->
                        R.singleton <| InGame mockInGameEmptyState
        in
            [ test "updateOrderSecondMove renders the first move correctly" <|
                \() ->
                    Expect.equal mockInGameOrderSecondMoveState model
            , test "updateOrderSecondMove won't render illegal moves" <|
                \() ->
                    Expect.equal badState secondState
            , test "updateOrder works as expected (from orderSecondMove)" <|
                \() ->
                    Expect.equal mockInGameOrderSecondMoveState <|
                        Tuple.first <|
                            updateOrder 0 0 <|
                                newState
            , test "updateGame works as expected (from orderSecondMove)" <|
                \() ->
                    Expect.equal mockInGameOrderSecondMoveState <|
                        Tuple.first <|
                            updateGame (Choose 0 0) newState
            ]


mockInGameChaosMoveState : GameState
mockInGameChaosMoveState =
    let
        m =
            { board = set 0 1 (Cell (Just Red) False 0 1) <| makeBoard
            , player1 = Player "1" Chaos 0
            , player2 = Player "2" Order 0
            , turn = Order
            , tiles = resetTiles <| initialSeed 5543
            , nextRound = True
            , message = Message.init
            , initSeed = initialSeed 5543
            }

        newTiles =
            randomTile m.tiles
    in
        m
            |> tilesL.set (TileState Nothing (Dict.fromList [ ( "red", 1 ) ]) newTiles.seed)
            |> InGame


mockInGameOrderFirstMoveState : GameState
mockInGameOrderFirstMoveState =
    let
        state =
            case mockInGameChaosMoveState of
                InGame st ->
                    st

                _ ->
                    mockInGameEmptyState
    in
        state
            |> modify boardL (Matrix.set 0 1 (Cell Nothing False 0 1) >> (highlightNeighbors 0 1))
            |> tilesL.set (TileState (Just Red) (Dict.fromList [ ( "red", 1 ) ]) state.tiles.seed)
            |> InGame


mockInGameOrderSecondMoveState : GameState
mockInGameOrderSecondMoveState =
    let
        state =
            case mockInGameOrderFirstMoveState of
                InGame st ->
                    { st | turn = Chaos }

                _ ->
                    mockInGameEmptyState

        newTiles =
            randomTile <| state.tiles
    in
        state
            |> modify boardL (Matrix.set 0 0 (Cell (Just Red) False 0 0) >> removeHighlights)
            |> tilesL.set newTiles
            |> iSeedL.set newTiles.seed
            |> InGame
