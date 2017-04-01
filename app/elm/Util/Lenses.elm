module Util.Lenses exposing (..)

import Monocle.Lens as Lens exposing (Lens)
import Monocle.Optional as Op exposing (Optional)
import Random exposing (Seed)
import Util.Types exposing (..)
import Message.Types as Message


p1L : Lens InGameState Player
p1L =
    Lens .player1 <| \a p -> { p | player1 = a }


p2L : Lens InGameState Player
p2L =
    Lens .player2 <| \a p -> { p | player2 = a }


scoreL : Lens Player Int
scoreL =
    Lens .score <| \s p -> { p | score = s }


roleL : Lens Player Role
roleL =
    Lens .role <| \r p -> { p | role = r }


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


msgL : Lens GameState Message.Model
msgL =
    let
        get s =
            case s of
                InGame st ->
                    st.message

                _ ->
                    { message = Message.Empty }

        set m s =
            case s of
                InGame st ->
                    InGame { st | message = m }

                OutGame st ->
                    OutGame st

                Config st ->
                    Config st
    in
        Lens get set


tilesL : Lens InGameState TileState
tilesL =
    Lens .tiles <| \t s -> { s | tiles = t }


currTileL : Lens TileState (Maybe Colour)
currTileL =
    Lens .current <| \c t -> { t | current = c }


tileSeedL : Lens TileState Seed
tileSeedL =
    Lens .seed <| \s t -> { t | seed = s }


currL : Lens InGameState (Maybe Colour)
currL =
    Lens.compose tilesL currTileL


seedL : Lens InGameState Seed
seedL =
    Lens.compose tilesL tileSeedL


iSeedL : Lens InGameState Seed
iSeedL =
    Lens .initSeed <| \s m -> { m | initSeed = s }


boardL : Lens InGameState Board
boardL =
    Lens .board <| \b m -> { m | board = b }


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
                a
                    |> lens.get
                    |> opt.getOption
    in
        Optional getOption set
