module Util.View exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (style)
import Util.Types exposing (..)


styleList : List (List Attr) -> Attribute Action
styleList =
    style << List.concat


htmlFromAttributes : List (Attribute Action) -> Html Action
htmlFromAttributes attributes =
    div attributes []


{-| (=>) - Takes 2 things and returns a Tuple of them.
    >>> "a" => 2
    ("a", 2)

    >>> "attribute" => "value"
    ("attribute", "value")
-}
(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type alias Attr =
    ( String, String )


hiddenStyle : List ( String, String )
hiddenStyle =
    [ "display" => "hidden" ]


tileToString : Colour -> String
tileToString colour =
    case colour of
        Red ->
            "red"

        Orange ->
            "orange"

        Green ->
            "green"

        Blue ->
            "blue"

        Violet ->
            "violet"


getHexColor : Colour -> String
getHexColor colour =
    case colour of
        Red ->
            "#f21f1f"

        Orange ->
            "#f78818"

        Green ->
            "#5fd813"

        Blue ->
            "#1953e5"

        Violet ->
            "#da1ee8"


flex : Int -> Int -> List Attr
flex x y =
    [ "flex" => ((toString x) ++ " " ++ (toString y) ++ " auto") ]


flexStyle : List Attr
flexStyle =
    [ "display" => "flex" ]


centerStyle : List Attr
centerStyle =
    [ "justify-content" => "center"
    , "align-items" => "center"
    ]


btnStyle : List Attr
btnStyle =
    [ "cursor" => "pointer" ]


columnStyle : List Attr
columnStyle =
    [ "flex-direction" => "column" ]


stretchStyle : List Attr
stretchStyle =
    [ "width" => "100%"
    , "height" => "100%"
    ]


jcsbStyle : List Attr
jcsbStyle =
    [ "justify-content" => "space-between" ]


styledBtnStyle : List Attr
styledBtnStyle =
    [ "box-sizing" => "border-box"
    , "padding" => "5px"
    , "background" => "#b61e64"
    , "color" => "white"
    , "border-radius" => "5px"
    ]
