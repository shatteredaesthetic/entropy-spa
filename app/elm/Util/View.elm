module Util.View exposing (..)

import Html exposing (Html, Attribute, div)
import Util.Types exposing (..)
import Styled exposing (..)


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



{-
   -- #f21f1f
   -- #f78818
   -- #5fd813
   -- #1953e5
   -- #da1ee8
   -- #1e0812
-}


getHexColor : Colour -> String
getHexColor colour =
    case colour of
        Red ->
            "f21f1f"

        Orange ->
            "f78818"

        Green ->
            "5fd813"

        Blue ->
            "1953e5"

        Violet ->
            "da1ee8"

        NoTile ->
            "1e0812"


columnWrap : StyledComponent
columnWrap =
    styled div
        [ display flex_
        , flexDirection column
        ]


centerWrap : StyledComponent
centerWrap =
    styled div
        [ display flex_
        , justifyContent center
        , alignItems center
        ]


stretchWrap : StyledComponent
stretchWrap =
    styled div
        [ width (percent 100)
        , height (percent 100)
        ]
