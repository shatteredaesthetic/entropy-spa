module Game.Board.State exposing (..)

import Matrix exposing (Matrix)
import Return as R exposing (Return)
import Return.Optics exposing (refractl)
import Monocle.Lens exposing (modify)
import Util.Types exposing (..)
import Util.State exposing (..)
import Util.Tiles exposing (randomTile)
import Util.Lenses exposing (..)
import Game.Message.State as Message
import Ctrl.State as Btn
import Util.Score exposing (score)


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

        Btn btnMsg ->
            Btn.update btnMsg <| InGame state

        _ ->
            R.singleton <| InGame state


updateOrder : Int -> Int -> InGameState -> Return Action GameState
updateOrder x y state =
    case currCellL.get state == emptyCell of
        True ->
            orderFirstMove x y state

        False ->
            orderSecondMove x y state.tiles.current state


orderFirstMove : Int -> Int -> InGameState -> Return Action GameState
orderFirstMove x y state =
    let
        colour_ =
            getCellColour x y state.board
    in
        case colour_ of
            NoTile ->
                InGame state
                    |> ret (setMsg "Select a Tile first.")

            _ ->
                state
                    |> (currCellL.set <| Cell colour_ False x y)
                    |> modify boardL ((Matrix.update x y (\cell -> { cell | colour = NoTile })) >> (highlightNeighbors x y))
                    |> InGame
                    |> ret (setMsg "Place tile in any Empty Cell.")


orderSecondMove : Int -> Int -> Cell -> InGameState -> Return Action GameState
orderSecondMove x y tile state =
    case getCellColour x y state.board of
        NoTile ->
            let
                newTiles =
                    randomTile state.tiles

                colour =
                    colourL.get tile
            in
                case validateOrder x y state of
                    InValid ->
                        R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")

                    Valid ->
                        { state | turn = Chaos }
                            |> modify boardL (Matrix.set x y (Cell colour False x y) >> removeHighlights)
                            |> tilesL.set newTiles
                            |> InGame
                            |> ret (setMsg "Place new Tile in any Empty Cell.")

                    NoMove ->
                        state
                            |> modify boardL (Matrix.set x y tile >> removeHighlights)
                            |> currCellL.set emptyCell
                            |> InGame
                            |> ret (setMsg "Select any tile of board.")

        _ ->
            InGame state
                |> ret (setMsg "Place Tile in any Empty Cell.")


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
                    |> currCellL.set emptyCell
                    |> (if state.nextRound then
                            (adjustPlyrs <| score newBoard) >> Break
                        else
                            (adjustPlyrs <| score newBoard) >> GameOver
                       )
                    |> R.singleton

            False ->
                if validateChaos x y state.board then
                    { state | turn = Order }
                        |> boardL.set newBoard
                        |> currCellL.set emptyCell
                        |> InGame
                        |> ret (setMsg "Select any Tile on Board.")
                else
                    R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")


adjustPlyrs : Int -> InGameState -> InGameState
adjustPlyrs pts state =
    let
        f ( l1, l2 ) l3 =
            state
                |> l1.set pts
                |> l2.set (switchRole <| l2.get state)
                |> l3.set (switchRole <| l3.get state)
    in
        if state.nextRound then
            f ( p2ScoreL, p2RoleL ) p1RoleL
        else
            f ( p1ScoreL, p1RoleL ) p2RoleL
