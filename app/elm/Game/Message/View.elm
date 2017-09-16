module Game.Message.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Game.Message.Types exposing (..)
import Game.Message.State exposing (messageL)
import Util.Types exposing (..)
import Styled exposing (..)


view : Model -> Html Action
view model =
    msgWrap
        [ class "game-footer" ]
        [ text <| ">  " ++ (showContent <| messageL.get model) ]


msgWrap : StyledComponent
msgWrap =
    styled div
        [ display flex_
        , flex (int 1) (int 0) (percent 25)
        , justifyContent flexStart
        , alignContent center
        , backgroundColor (hex "312c32")
        , color (hex "feffff")
        , fontFamily monospace
        , fontSize (em 1.5)
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
