module Game.Message.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (id)
import Game.Message.Types exposing (..)
import Util.View exposing (..)
import Util.Types exposing (..)


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
            styleList [ flexStyle, centerStyle, footerStyle, bgColor "#1e0812", flex 1 0 ]
    in
        div
            [ id "game-footer"
            , style_
            ]
            [ div
                [ id "game-footer-inner" ]
                [ text <| ">  " ++ content ]
            ]


footerStyle : List Attr
footerStyle =
    [ "color" => "#fafafa"
    , "font-family" => "Monospace"
    , "box-shadow" => "inset 0px 3px 3px 0px #d8d8d8"
    ]
