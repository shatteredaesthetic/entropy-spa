module Game.Message.View exposing (..)

import Html exposing (Html, div, text)
import Game.Message.Types exposing (..)
import Util.View exposing (..)
import Util.Types exposing (..)
import Game.Message.Styles exposing (..)


{ id, class, classList } =
    messageNS


view : Model -> Html Action
view model =
    let
        content =
            case model.message of
                Empty ->
                    ""

                Adding m ->
                    m.show

                Removing m ->
                    m.show

        style_ =
            styleList
    in
        div
            [ id MsgPanel ]
            [ div [] [ text <| ">  " ++ content ]
            ]
