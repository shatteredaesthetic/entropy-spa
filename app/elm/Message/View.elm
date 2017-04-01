module Message.View exposing (..)

import Message.Types exposing (..)


view : Model -> String
view model =
    case model.message of
        Empty ->
            ""

        Adding m ->
            m.show

        Removing m ->
            m.show
