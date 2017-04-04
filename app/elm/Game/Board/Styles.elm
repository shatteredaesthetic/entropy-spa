module Game.Board.Styles exposing (..)

import Util.Types exposing (..)
import Util.View exposing (..)


highlightStyle : Cell -> List Attr
highlightStyle cell =
    case cell.highlight of
        True ->
            [ "background" => "#f4fc14" ]

        False ->
            []


tileStyle : List Attr
tileStyle =
    [ "border" => "1px solid #8d8d8d"
    , "border-radius" => "4px"
    , "z-index" => "1"
    , "background" => "#1e0812"
    ]


boardContainerStyle : List Attr
boardContainerStyle =
    [ "height" => "70vh"
    , "width" => "70vh"
    ]


cellBtnStyle : List Attr
cellBtnStyle =
    [ "width" => "90%"
    , "height" => "90%"
    , "border-radius" => "5px"
    , "box-sizing" => "border-box"
    , "position" => "relative"
    , "z-index" => "10"
    ]
