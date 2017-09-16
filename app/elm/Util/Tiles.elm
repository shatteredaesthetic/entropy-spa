module Util.Tiles exposing (randomTile)

import Random exposing (Generator, int, Seed)
import Dict
import Util.Types exposing (..)
import Util.State exposing (newTile)
import Util.Lenses exposing (tileSeedL, currTileL)
import Util.View exposing (tileToString)


tileGenerator : Generator Int -> Generator Colour
tileGenerator intGenerator =
    Random.map (intToTile 5) intGenerator


randomTile : TileState -> TileState
randomTile tile =
    let
        ( nTile, newSeed ) =
            Random.step (tileGenerator (int 0 5)) tile.seed

        newKey =
            tileToString nTile
    in
        case Dict.get newKey tile.ref of
            Nothing ->
                { tile | ref = Dict.insert newKey 1 tile.ref }
                    |> (currTileL.set <| newTile nTile)
                    |> tileSeedL.set newSeed

            Just val ->
                if (val < 5) then
                    { tile
                        | ref =
                            Dict.map
                                (\k v ->
                                    if k == newKey then
                                        v + 1
                                    else
                                        v
                                )
                                tile.ref
                    }
                        |> (currTileL.set <| newTile nTile)
                        |> tileSeedL.set newSeed
                else
                    randomTile { tile | seed = newSeed }


intToTile : Int -> Int -> Colour
intToTile size colorIdx =
    case (colorIdx % size) of
        0 ->
            Red

        1 ->
            Orange

        2 ->
            Green

        3 ->
            Blue

        4 ->
            Violet

        _ ->
            NoTile
