module Util.View exposing (..)

import Html exposing (Html, Attribute, div, text)
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


sideWrap : StyledComponent
sideWrap =
    styled columnWrap
        [ justifyContent flexEnd
        , alignItems stretch
        , flex (int 1) (int 0) (percent 20)
        , paddingBottom (Styled.rem 1)
        ]


sidePanel : Player -> Html Action
sidePanel plyr =
    sideWrap []
        [ emptyDiv
        , plyrWrap []
            [ nameWrap [] [ text <| String.left 7 plyr.name ]
            , scoreWrap [] [ text <| toString plyr.score ]
            ]
        ]


emptyDiv : Html Action
emptyDiv =
    styled div
        [ display flex_
        , flex (int 4) (int 0) (percent 70)
        ]
        []
        []


plyrWrap : StyledComponent
plyrWrap =
    styled columnWrap
        [ flex (int 1) (int 0) (percent 30)
        , justifyContent center
        , alignItems center
        , width (percent 100)
        ]


nameWrap : StyledComponent
nameWrap =
    styled centerWrap
        [ color (hex "98dafc")
        , flex (int 1) (int 0) (percent 35)
        , textShadow zero zero (px 10) (hex "feffff")
        , backgroundColor (hex "312c32")
        , fontSize (em 5)
        , paddingBottom (Styled.rem 1)
        , width (percent 100)
        ]


scoreWrap : StyledComponent
scoreWrap =
    styled centerWrap
        [ color (hex "312c32")
        , flex (int 2) (int 0) (percent 65)
        , textShadow zero zero (px 10) (hex "daad86")
        , backgroundColor (hex "98dafc")
        , fontSize (em 8)
        , width (percent 100)
        ]
