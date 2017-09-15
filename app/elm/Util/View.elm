module Util.View exposing (..)

import Html exposing (Html, Attribute, div)
import Util.Types exposing (..)


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


getHexColor : Colour -> String
getHexColor colour =
    case colour of
        Red ->
            "f21f1f"

        -- #f21f1f
        Orange ->
            "f78818"

        -- #f78818
        Green ->
            "5fd813"

        -- #5fd813
        Blue ->
            "1953e5"

        -- #1953e5
        Violet ->
            "da1ee8"

        -- #da1ee8
        NoTile ->
            "1e0812"



-- #1e0812
