module Game.Message.State exposing (..)

import Time exposing (second, millisecond)
import Return as R exposing (Return)
import Monocle.Lens as Lens exposing (Lens)
import Util.State exposing (delay, ret)
import Game.Message.Types exposing (..)


init : Model
init =
    { message = Empty }


messageL : Lens Model Message
messageL =
    Lens .message <| \s m -> { m | message = s }


update : Msg -> Model -> Return Msg Model
update msg model =
    case msg of
        Add ->
            case model.message of
                Adding m ->
                    if String.isEmpty m.hide then
                        model
                            |> messageL.set (Removing m)
                            |> ret (delay (1 * second) Remove)
                    else
                        model
                            |> messageL.set (Adding <| addTrans m)
                            |> ret (delay (35 * millisecond) Add)

                _ ->
                    R.singleton model

        Remove ->
            case model.message of
                Removing m ->
                    if String.isEmpty m.show then
                        model
                            |> messageL.set Empty
                            |> R.singleton
                    else
                        model
                            |> messageL.set (Removing <| removeTrans m)
                            |> ret (delay (35 * millisecond) Remove)

                _ ->
                    R.singleton model

        Print s ->
            model
                |> messageL.set (Adding <| initTrans s)
                |> ret (delay (35 * millisecond) Add)


initTrans : String -> MsgTransition
initTrans str =
    MsgTransition "" str


addTrans : MsgTransition -> MsgTransition
addTrans t =
    { t
        | show = String.append t.show <| String.left 1 t.hide
        , hide = String.dropLeft 1 t.hide
    }


removeTrans : MsgTransition -> MsgTransition
removeTrans t =
    { t | show = String.dropRight 1 t.show }
