module Config.Styles exposing (..)

import Util.View exposing (..)


infoStyle : List Attr
infoStyle =
    List.concat [ bgColor "#1e0812", txtCol "#d8d8d8" ]


anchorStyle : List Attr
anchorStyle =
    List.concat [ txt, [ "text-decoration" => "none" ] ]


titleStyle : List Attr
titleStyle =
    List.concat [ txt, bgColor "#d8d8d8", boldF, [ "font-size" => "3em" ] ]


labelStyle : List Attr
labelStyle =
    List.concat [ txt, boldF ]


centerBtnStyle : List Attr
centerBtnStyle =
    List.concat [ txt, aiStyle "space-around" ]


boldF : List Attr
boldF =
    [ "font-weight" => "bold" ]


txt : List Attr
txt =
    txtCol "#b61e64"
