module Board.Styles exposing (..)

import Util.Types exposing (..)
import Util.View exposing (..)


highlightStyle : Cell -> List Attr
highlightStyle cell =
    case cell.highlight of
        True ->
            [ "background" => "#f4fc14" ]

        False ->
            []


currentTileStyle : InGameState -> List Attr
currentTileStyle state =
    let
        bg =
            case state.tiles.current of
                Nothing ->
                    [ "background" => "#1e0812" ]

                Just colour ->
                    [ "background" => getHexColor colour ]

        base =
            [ "width" => "80%"
            , "height" => "80%"
            ]
    in
        List.concat [ bg, base ]


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


headerStyle : List Attr
headerStyle =
    [ "background" => "#d8d8d8"
    , "margin-bottom" => "5px"
    ]


footerStyle : List Attr
footerStyle =
    [ "background" => "#1e0812"
    , "color" => "#fafafa"
    , "font-family" => "Monospace"
    , "box-shadow" => "inset 0px 3px 3px 0px #d8d8d8"
    , "height" => "10vh"
    ]


playerNameStyle : List Attr
playerNameStyle =
    [ "font-size" => "5em"
    , "align-items" => "center"
    , "color" => "#1e0812"
    , "font-weight" => "bold"
    ]


tokenStyle : List Attr
tokenStyle =
    [ "box-sizing" => "border-box"
    , "border" => "5px solid #1e0812"
    , "font-size" => "7em"
    , "font-weight" => "bolder"
    , "padding" => "5px"
    , "color" => "#b61e64"
    , "text-shadow" => "0px 1px 2px #1e0812, inset 0px 3px 2px #fafafa"
    ]


cellBtnStyle : List Attr
cellBtnStyle =
    [ "width" => "90%"
    , "height" => "90%"
    , "border-radius" => "5px"
    , "box-sizing" => "border-box"
    , "z-index" => "5"
    ]
