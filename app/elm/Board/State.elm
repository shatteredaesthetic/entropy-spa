module Board.State exposing (..)

import Matrix exposing (Matrix)
import Return as R exposing (Return)
import Return.Optics exposing (refractl)
import Monocle.Lens exposing (modify)
import Util.Types exposing (..)
import Util.State exposing (..)
import Util.Tiles exposing (randomTile)
import Util.Lenses exposing (..)
import Message.State as Message
import Score exposing (score)


updateGame : Action -> InGameState -> Return Action GameState
updateGame action state =
    case action of
        Choose x y ->
            case state.turn of
                Chaos ->
                    updateChaos x y state

                Order ->
                    updateOrder x y state

        Msg msg ->
            InGame state
                |> R.singleton
                |> (refractl msgL Msg <| Message.update msg)

        _ ->
            R.singleton <| InGame state


updateOrder : Int -> Int -> InGameState -> Return Action GameState
updateOrder x y state =
    case state.tiles.current of
        Nothing ->
            orderFirstMove x y state

        Just tile ->
            orderSecondMove x y tile state


orderFirstMove : Int -> Int -> InGameState -> Return Action GameState
orderFirstMove x y state =
    case getCellColour x y state.board of
        Nothing ->
            InGame state
                |> ret (setMsg "Select a Tile first.")

        Just colour ->
            state
                |> modify boardL ((Matrix.update x y (\cell -> { cell | colour = Nothing })) >> (highlightNeighbors x y))
                |> currL.set (Just colour)
                |> InGame
                |> ret (setMsg "Place tile in any Empty Cell.")


orderSecondMove : Int -> Int -> Colour -> InGameState -> Return Action GameState
orderSecondMove x y tile state =
    case getCellColour x y state.board of
        Just _ ->
            InGame state
                |> ret (setMsg "Place Tile in any Empty Cell.")

        Nothing ->
            let
                newTiles =
                    randomTile state.tiles
            in
                if validateOrder x y state.board then
                    { state | turn = Chaos }
                        |> modify boardL (Matrix.set x y (Cell (Just tile) False x y) >> removeHighlights)
                        |> iSeedL.set newTiles.seed
                        |> tilesL.set newTiles
                        |> InGame
                        |> ret (setMsg "Place new Tile in any Empty Cell.")
                else
                    R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")


updateChaos : Int -> Int -> InGameState -> Return Action GameState
updateChaos x y state =
    let
        newBoard =
            Matrix.set x y (Cell (currL.get state) False x y) state.board
    in
        case isBoardFull newBoard of
            True ->
                state
                    |> boardL.set newBoard
                    |> (if state.nextRound then
                            makeBreak <| score newBoard
                        else
                            makeBreak <| score newBoard
                       )

            False ->
                if validateChaos x y state.board then
                    { state | turn = Order }
                        |> boardL.set newBoard
                        |> currL.set Nothing
                        |> InGame
                        |> ret (setMsg "Select any Tile on Board.")
                else
                    R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")


makeBreak : Int -> InGameState -> Return Action GameState
makeBreak pts state =
    let
        f l1 l2 l3 =
            state
                |> l1.set pts
                |> l2.set (switchRole <| l2.get state)
                |> l3.set (switchRole <| l3.get state)
                |> OutGame
                |> R.singleton
    in
        if state.nextRound then
            f p1ScoreL p1RoleL p2RoleL
        else
            f p2ScoreL p2RoleL p1RoleL
