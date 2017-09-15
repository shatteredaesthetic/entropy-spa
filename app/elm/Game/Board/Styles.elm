module Game.Board.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace boardNS.name)
        [ id GameInner
            [ displayFlex, boardContainerStyle ]
        , id GameContainer
            [ displayFlex, centerStyle, flex2 (int 4) (int 0), bgColor "1e0812" ]
        , class BoardCell
            [ displayFlex, centerStyle, rel, tileStyle, flex2 (int 1) (int 0) ]
        , class CellBtn
            [ cellBtnStyle ]
        , class BoardRow
            [ displayFlex, columnStyle, flex2 (int 1) (int 0) ]
        ]


highlightStyle : Cell -> List Attr
highlightStyle cell =
    case cell.highlight of
        True ->
            [ "background" => "#f4fc14" ]

        False ->
            []


tileStyle : Mixin
tileStyle =
    mixin
        [ border3 (px 1) solid (hex "8d8d8d")
        , borderRadius (px 4)
        , zIndex (int 1)
        , bgColor "1e0812"
        ]


boardContainerStyle : Mixin
boardContainerStyle =
    mixin
        [ height (vh 70)
        , width (vw 70)
        ]


cellBtnStyle : Mixin
cellBtnStyle =
    mixin
        [ width (pct 90)
        , height (pct 90)
        , borderRadius (px 5)
        , boxSizing borderBox
        , position relative
        , zIndex (int 10)
        ]


boardNS : Namespace String class id msg
boardNS =
    withNamespace "board"
