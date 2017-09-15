module Game.Message.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Game.Message.Types exposing (..)
import Util.Types exposing (..)
import Styled exposing (..)


view : Model -> Html Action
view model =
    msgCont
        [ class "game-footer" ]
        [ text <| ">  " ++ showContent model.message ]


msgCont : StyledComponent
msgCont =
    styled div
        [ display flex_
        , flex (int 1) (int 0) auto
        , justifyContent flexStart
        , alignContent center
        , backgroundColor (hex "1e0812")
        , color (hex "fafafa")
        , fontFamily monospace
        , boxShadow (px 0) (px 2) (px 2) (px 0) (hex "d8d8d8")
        ]


showContent : Message -> String
showContent msg =
    case msg of
        Empty ->
            ""

        Adding m ->
            m.show

        Removing m ->
            m.show
