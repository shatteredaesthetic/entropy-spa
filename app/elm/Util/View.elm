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

        NoTile ->
            "EMPTY"


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

        NoTile ->
            "#1e0812"


flex : Int -> Int -> List Attr
flex x y =
    [ "flex" => ((toString x) ++ " " ++ (toString y) ++ " auto") ]


flexStyle : List Attr
flexStyle =
    [ "display" => "flex" ]


centerStyle : List Attr
centerStyle =
    List.concat [ jcStyle "center", aiStyle "center" ]


btnStyle : List Attr
btnStyle =
    [ "cursor" => "pointer" ]


bgColor : String -> List Attr
bgColor str =
    [ "background" => str ]


columnStyle : List Attr
columnStyle =
    [ "flex-direction" => "column" ]


stretchStyle : List Attr
stretchStyle =
    List.concat [ wd "100%", ht "100%" ]


jcStyle : String -> List Attr
jcStyle str =
    [ "justify-content" => str ]


aiStyle : String -> List Attr
aiStyle str =
    [ "align-items" => str ]


styledBtnStyle : List Attr
styledBtnStyle =
    [ "box-sizing" => "border-box"
    , "padding" => "5px"
    , "background" => "#b61e64"
    , "color" => "white"
    , "border-radius" => "5px"
    ]


ht : String -> List Attr
ht h =
    [ "height" => h ]


wd : String -> List Attr
wd w =
    [ "width" => w ]


rel : List Attr
rel =
    [ "position" => "relative" ]


outerContainer : List Attr
outerContainer =
    List.concat [ wd "100vw", ht "100vh", bgColor "#1e0812" ]


txtCol : String -> List Attr
txtCol str =
    [ "color" => str ]
