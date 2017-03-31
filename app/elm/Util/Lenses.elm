module Util.Lenses exposing (..)

import Monocle.Lens as Lens exposing (Lens)
import Monocle.Optional as Op exposing (Optional)
import Random exposing (Seed)
import Util.Types exposing (..)


p1L : Lens InGameState Player
p1L =
    let
        get p =
            p.player1

        set a p =
            { p | player1 = a }
    in
        Lens get set


p2L : Lens InGameState Player
p2L =
    let
        get p =
            p.player2

        set a p =
            { p | player2 = a }
    in
        Lens get set


scoreL : Lens Player Int
scoreL =
    let
        get p =
            p.score

        set s p =
            { p | score = s }
    in
        Lens get set


roleL : Lens Player Role
roleL =
    let
        get p =
            p.role

        set r p =
            { p | role = r }
    in
        Lens get set


p1ScoreL : Lens InGameState Int
p1ScoreL =
    Lens.compose p1L scoreL


p2ScoreL : Lens InGameState Int
p2ScoreL =
    Lens.compose p2L scoreL


p1RoleL : Lens InGameState Role
p1RoleL =
    Lens.compose p1L roleL


p2RoleL : Lens InGameState Role
p2RoleL =
    Lens.compose p2L roleL


msgL : Lens InGameState Cont
msgL =
    let
        get s =
            s.message

        set m s =
            { s | message = m }
    in
        Lens get set


tilesL : Lens InGameState TileState
tilesL =
    let
        get s =
            s.tiles

        set t s =
            { s | tiles = t }
    in
        Lens get set


currTileL : Optional TileState Colour
currTileL =
    let
        get t =
            t.current

        set c t =
            { t | current = Just c }
    in
        Optional get set


tileSeedL : Lens TileState Seed
tileSeedL =
    let
        get t =
            t.seed

        set s t =
            { t | seed = s }
    in
        Lens get set


currL : Optional InGameState Colour
currL =
    composeOpt tilesL currTileL


seedL : Lens InGameState Seed
seedL =
    Lens.compose tilesL tileSeedL


composeOpt : Lens a b -> Optional b c -> Optional a c
composeOpt lens opt =
    let
        set c a =
            lens.get a
                |> opt.set c
                |> (\b -> lens.set b a)

        getOption a =
            let
                x =
                    lens.get a
            in
                case opt.getOption x of
                    Nothing ->
                        Nothing

                    Just b ->
                        Just b
    in
        Optional getOption set
