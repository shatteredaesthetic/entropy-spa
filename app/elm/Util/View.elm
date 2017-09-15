module Util.View exposing (..)

import Css exposing (..)
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


hiddenStyle : Mixin
hiddenStyle =
    mixin [ display none ]


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


flex : Int -> Int -> Mixin
flex x y =
    mixin [ flex2 (int x) (int y) ]


centerStyle : Mixin
centerStyle =
    mixin [ justifyContent center, alignItems center ]


btnStyle : Mixin
btnStyle =
    mixin
        [ cursor pointer
        , displayFlex
        , centerStyle
        ]


bgColor : String -> Mixin
bgColor str =
    mixin [ backgroundColor <| hex str ]


columnStyle : Mixin
columnStyle =
    mixin [ flexDirection column ]


stretchStyle : Mixin
stretchStyle =
    mixin [ width (pct 1.0), height (pct 1.0) ]


styledBtnStyle : Mixin
styledBtnStyle =
    mixin
        [ boxSizing borderBox
        , color <| hex "fafafa"
        , padding (px 5)
        , backgroundColor <| hex "b61e64"
        , borderRadius (px 5)
        ]


rel : Mixin
rel =
    mixin [ position relative ]


outerContainer : Mixin
outerContainer =
    mixin [ width (vw 100), height (vh 100), bgColor "1e0812" ]


txtCol : String -> Mixin
txtCol str =
    mixin [ color <| hex str ]
