module Config.State exposing (..)

import Return as R exposing (Return)
import Ctrl.State as Btn
import Util.Types exposing (..)


updateConfig : Action -> ConfigState -> Return Action GameState
updateConfig action cfg =
    case action of
        SetPlayer1 str ->
            R.singleton <| Config { cfg | player1name = str }

        SetPlayer2 str ->
            R.singleton <| Config { cfg | player2name = str }

        Btn btnMsg ->
            Btn.update btnMsg <| Config cfg

        _ ->
            R.singleton <| Config cfg
