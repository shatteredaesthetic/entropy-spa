module Message.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Message.Types exposing (..)
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
    in
        div
            [ class "game-footer"
            , styleList [ flexStyle, centerStyle, footerStyle, (flex 1 0) ]
            ]
            [ div
                [ class "game-footer-inner" ]
                [ text <| ">  " ++ content ]
            ]


footerStyle : List Attr
footerStyle =
    [ "background" => "#1e0812"
    , "color" => "#fafafa"
    , "font-family" => "Monospace"
    , "box-shadow" => "inset 0px 3px 3px 0px #d8d8d8"
    , "height" => "10vh"
    ]
