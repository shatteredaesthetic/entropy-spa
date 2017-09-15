module Util.State exposing (..)

import Matrix exposing (..)
import Time exposing (Time)
import Task exposing (succeed)
import Process exposing (sleep)
import Array
import Dict
import Return as R exposing (Return)
import Random exposing (Seed, initialSeed)
import Util.Types exposing (..)
import Game.Message.Types exposing (Msg(Print))


{-| switchRole - Toggles Role
    >>> switchRole Chaos
    Order
    >>> switchRole Order
    Chaos
-}
switchRole : Role -> Role
switchRole role =
    case role of
        Chaos ->
            Order

        Order ->
            Chaos


{-| getCellColour - gets the Maybe Colour out of a cell's .colour
    >>> import Util.Types exposing (..)
    >>> import Matrix
    >>> getCellColour 0 0 <| Matrix.set 0 0 (Cell Red False 0 0) <| makeBoard
    Red
    >>> getCellColour 4 4 <| makeBoard
    NoTile
    >>> getCellColour 2 3 <| Matrix.set 2 3 (Cell Orange False 2 3) <| makeBoard
    Orange
-}
getCellColour : Int -> Int -> Board -> Colour
getCellColour x y board =
    case Matrix.get x y board of
        Nothing ->
            NoTile

        Just cell ->
            cell.colour


{-| makeBoard - instanitate an empty board
    >>> import Util.Types exposing (..)
    >>> import Matrix
    >>> boardEmpty <| makeBoard
    True
    >>> boardEmpty <| Matrix.set 0 0 (Cell Red False 0 0) <| makeBoard
    False
-}
makeBoard : Board
makeBoard =
    let
        m =
            Matrix.repeat 5 5 NoTile

        f x y el =
            Cell el False x y
    in
        Matrix.indexedMap f m


{-| isBoardFull - Predicate to check if the board is full, ie. all cells have a Just Colour in their .colour
    >>> import Util.Types exposing (..)
    >>> import Matrix
    >>> isBoardFull <| makeBoard
    False
-}
isBoardFull : Board -> Bool
isBoardFull =
    Array.isEmpty << Matrix.filter (\cell -> cell.colour == NoTile)


{-| validateOrder - Validates Order's move, ie. if the cell is highlighted
    >>> import Util.Types exposing (..)
    >>> import Matrix
    >>> validateOrder 0 0 <| Matrix.set 0 0 (Cell NoTile True 0 0) <| makeBoard
    True
    >>> validateOrder 1 1 <| makeBoard
    False
-}
validateOrder : Int -> Int -> Board -> Bool
validateOrder x y board =
    case Matrix.get x y board of
        Nothing ->
            False

        Just cell ->
            cell.highlight


{-| validateChaos - Validate's Chaos' move, ie. if the cell has a colour of Nothing
    >>> import Util.Types exposing (..)
    >>> import Matrix
    >>> validateChaos 0 0 <| makeBoard
    True
    >>> validateChaos 1 1 <| Matrix.set 1 1 (Cell Red False 1 1) <| makeBoard
    False
-}
validateChaos : Int -> Int -> Board -> Bool
validateChaos x y board =
    case Matrix.get x y board of
        Nothing ->
            False

        Just cell ->
            case cell.colour of
                NoTile ->
                    True

                _ ->
                    False


highlightNeighbors : Int -> Int -> Board -> Board
highlightNeighbors x y board =
    let
        highlightCell cell =
            case cell.colour of
                NoTile ->
                    { cell | highlight = not cell.highlight }

                _ ->
                    cell
    in
        board
            |> Matrix.update (x + 1) y highlightCell
            |> Matrix.update (x - 1) y highlightCell
            |> Matrix.update x (y + 1) highlightCell
            |> Matrix.update x (y - 1) highlightCell


removeHighlights : Board -> Board
removeHighlights =
    Matrix.map (\cell -> { cell | highlight = False })


resetTiles : Seed -> TileState
resetTiles =
    TileState NoTile Dict.empty


setMsg : String -> Cmd Action
setMsg =
    (Task.perform Msg) << succeed << Print


delay : Time -> msg -> Cmd msg
delay time msg =
    sleep time
        |> Task.andThen (always <| Task.succeed msg)
        |> Task.perform identity


ret : Cmd msg -> a -> Return msg a
ret =
    flip R.return


boardEmpty : Board -> Bool
boardEmpty board =
    board
        |> Matrix.map .colour
        |> .data
        |> Array.toList
        |> List.all (\c -> c /= NoTile)
