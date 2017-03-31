module State exposing (updateState)

import Return as R exposing (Return)
import Util.Types exposing (..)
import Util.Tiles exposing (..)
import Util.State exposing (makeBoard, resetTiles, switchRole, setMsg, ret)
import Board.State exposing (updateGame)


updateState : Action -> GameState -> Return Action GameState
updateState action state =
    case state of
        Config cfg ->
            updateConfig action cfg

        InGame state ->
            updateGame action state

        OutGame state ->
            updateBreak action state


updateBreak : Action -> InGameState -> Return Action GameState
updateBreak action state =
    case action of
        NextRound ->
            R.singleton <|
                InGame
                    { state
                        | round = 2
                        , turn = Chaos
                        , board = makeBoard
                        , tiles = resetTiles state.initSeed
                    }

        NewGame ->
            Config (ConfigState "" "" state.initSeed) |> R.singleton

        ScoreChaos (Ok payload) ->
            let
                plyr1 =
                    state.player1

                plyr2 =
                    state.player2
            in
                case payload.round of
                    1 ->
                        let
                            newPlyr =
                                { plyr1
                                    | score = payload.score
                                    , role = switchRole plyr1.role
                                }
                        in
                            R.singleton <| OutGame { state | player1 = newPlyr }

                    _ ->
                        let
                            newPlyr =
                                { plyr2
                                    | score = payload.score
                                    , role = switchRole plyr2.role
                                }
                        in
                            R.singleton <| OutGame { state | player2 = newPlyr }

        _ ->
            R.singleton <| OutGame state


updateConfig : Action -> ConfigState -> Return Action GameState
updateConfig action cfg =
    case action of
        SetPlayer1 str ->
            R.singleton <| Config { cfg | player1name = str }

        SetPlayer2 str ->
            R.singleton <| Config { cfg | player2name = str }

        StartGame ->
            InGame
                { board = makeBoard
                , player1 = Player cfg.player1name Chaos 0
                , player2 = Player cfg.player2name Order 0
                , turn = Chaos
                , tiles = randomTile <| resetTiles cfg.initSeed
                , message = DoCont ""
                , round = 1
                , initSeed = cfg.initSeed
                }
                |> ret (setMsg "Place tile in any empty square")

        _ ->
            R.singleton <| Config cfg
