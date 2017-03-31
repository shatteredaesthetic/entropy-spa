module Config.Styles exposing (..)

import Util.View exposing (..)


infoStyle : List Attr
infoStyle =
    [ "background" => "#1e0812"
    , "color" => "#d8d8d8"
    ]


anchorStyle : List Attr
anchorStyle =
    [ "color" => "#b61e64"
    , "text-decoration" => "none"
    ]


titleStyle : List Attr
titleStyle =
    [ "color" => "#b61e64"
    , "background" => "#d8d8d8"
    , "position" => "relative"
    , "left" => "20px"
    , "font-size" => "3em"
    , "font-weight" => "bold"
    ]


topContainerStyle : List Attr
topContainerStyle =
    [ "box-shadow" => "inset 0px -2px 2px 0px #1e0812"
    , "background" => "#d8d8d8"
    , "height" => "25vh"
    ]


alignStyle : List Attr
alignStyle =
    [ "align-items" => "center" ]


labelStyle : List Attr
labelStyle =
    [ "color" => "#b61e64"
    , "font-weight" => "bold"
    ]


centerBtnStyle : List Attr
centerBtnStyle =
    [ "color" => "#b61e64"
    , "align-items" => "space-around"
    ]
