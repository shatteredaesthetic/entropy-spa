module Board.State exposing (updateGame)

import Matrix exposing (Matrix)
import Time exposing (millisecond)
import Return as R exposing (Return)
import Util.Types exposing (..)
import Util.State exposing (..)
import Util.Tiles exposing (randomTile)
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

        MsgIn str ->
            case state.message of
                DoCont string ->
                    case str of
                        Empty ->
                            R.singleton (InGame state)
                                |> R.command (delay (3000 * millisecond) (MsgOut <| Show string))

                        Show s ->
                            if String.length s == 1 then
                                InGame { state | message = DoCont <| String.concat [ string, s ] }
                                    |> R.singleton
                                    |> R.command (delay (75 * millisecond) (MsgIn Empty))
                            else
                                InGame { state | message = DoCont <| String.concat [ string, String.left 1 s ] }
                                    |> R.singleton
                                    |> R.command (delay (75 * millisecond) (MsgIn <| Show <| String.dropLeft 1 s))

                NoCont string ->
                    R.singleton (InGame state)

        MsgOut str ->
            case state.message of
                DoCont string ->
                    case str of
                        Empty ->
                            InGame { state | message = DoCont "" }
                                |> R.singleton

                        Show s ->
                            if String.length s == 1 then
                                InGame { state | message = DoCont s }
                                    |> ret (delay (25 * millisecond) (MsgOut <| Empty))
                            else
                                InGame { state | message = DoCont s }
                                    |> ret (delay (25 * millisecond) (MsgOut <| Show <| String.dropRight 1 s))

                NoCont string ->
                    InGame state ! []

        NoMsg ->
            case state.message of
                DoCont str ->
                    InGame { state | message = NoCont str } ! []

                NoCont str ->
                    InGame { state | message = DoCont str } ! []

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
            { state
                | board =
                    state.board
                        |> Matrix.update x y (\cell -> { cell | colour = Nothing })
                        |> highlightNeighbors x y
            }
                |> setNewTiles (Just colour)
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
                newCell =
                    Cell (Just tile) False x y

                newTiles =
                    randomTile state.tiles
            in
                if validateOrder x y state.board then
                    InGame
                        { state
                            | board =
                                state.board
                                    |> Matrix.set x y newCell
                                    |> removeHighlights
                            , tiles = newTiles
                            , turn = Chaos
                            , initSeed = newTiles.seed
                        }
                        |> ret (setMsg "Place new Tile in any Empty Cell.")
                else
                    R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")


updateChaos : Int -> Int -> InGameState -> Return Action GameState
updateChaos x y state =
    let
        newCell =
            Cell (state.tiles.current) False x y

        newBoard =
            Matrix.set x y newCell state.board
    in
        case isBoardFull newBoard of
            True ->
                case state.round of
                    1 ->
                        makeBreak state newBoard Player1 <| score state.board

                    _ ->
                        makeBreak state newBoard Player2 <| score state.board

            False ->
                if validateChaos x y state.board then
                    { state
                        | board = newBoard
                        , turn = switchRole state.turn
                    }
                        |> setNewTiles Nothing
                        |> InGame
                        |> ret (setMsg "Select any Tile on Board.")
                else
                    R.return (InGame state) (setMsg "You can't put a Tile on another Tile.")


type PlayerProxy
    = Player1
    | Player2


makeBreak : InGameState -> Board -> PlayerProxy -> Int -> Return Action GameState
makeBreak state newBoard plyr pts =
    case plyr of
        Player1 ->
            let
                player1 =
                    state.player1

                player2 =
                    state.player2
            in
                { state
                    | board = newBoard
                    , player1 = { player1 | score = pts }
                    , player2 = { player2 | role = switchRole player2.role }
                }
                    |> OutGame
                    |> R.singleton

        Player2 ->
            let
                player1 =
                    state.player1

                player2 =
                    state.player2
            in
                { state
                    | board = newBoard
                    , player1 = { player1 | role = switchRole player1.role }
                    , player2 = { player2 | score = pts }
                }
                    |> OutGame
                    |> R.singleton
