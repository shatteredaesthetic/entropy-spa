module Game.Player.Styles exposing (..)

import Util.Types exposing (..)
import Util.View exposing (..)


currentTileStyle : InGameState -> List Attr
currentTileStyle state =
    List.concat [ bgColor <| getHexColor state.tiles.current, wd "80%", ht "80%" ]


playerNameStyle : List Attr
playerNameStyle =
    [ "font-size" => "5em"
    , "color" => "#1e0812"
    , "font-weight" => "bold"
    ]


innerStyle : List Attr
innerStyle =
    [ "background" => "#1e0812" ]


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
