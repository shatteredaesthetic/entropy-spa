module Game.Player.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace playerNS.name)
        [ id P1Container
            [ displayFlex, columnStyle, bgColor "#d8d8d8", flex2 (int 1) (int 0) ]
        , id P1Token
            [ displayFlex, alignItems flexEnd ]
        , id P2Token
            [ displayFlex, alignItems flexStart ]
        , id SelectedTile
            [ displayFlex, centerStyle ]
        , class TopContainer
            [ displayFlex, columnStyle, alignItems flexStart, flex2 (int 3) (int 0) ]
        , class PlayerName
            [ alignItems center, txtCol "fafafa" ]
        , class PlayerScore
            [ displayFlex, centerStyle, txtCol "#fafafa" ]
        , class BottomContainer
            [ displayFlex, alignItems flexEnd, flex2 (int 1) (int 0) ]
        , class NameContainer
            [ displayFlex, centerStyle ]
        , class ScoreContainer
            [ displayFlex ]
        , class TokenContainer
            [ displayFlex, centerStyle ]
        , class TokenInner
            [ displayFlex, centerStyle, bgColor "1e0812" ]
        , class PlayerToken
            [ tokenStyle, flex2 (int 1) (int 0) ]
        ]


currentTileStyle : Colour -> Mixin
currentTileStyle tile =
    mixin [ bgColor <| getHexColor tile, width (pct 80), height (pct 80) ]


playerNameStyle : Mixin
playerNameStyle =
    mixin
        [ fontSize (em 5)
        , txtCol "1e0812"
        , fontWeight bold
        ]


tokenStyle : Mixin
tokenStyle =
    mixin
        [ boxSizing borderBox
        , border3 (px 5) solid <| hex "1e0812"
        , fontSize (em 7)
        , fontWeight bold
        , padding (px 5)
        , txtCol "b61e64"
        ]


playerNS : Namespace String class id msg
playerNS =
    withNamespace "player"



-- "text-shadow" => "0px 1px 2px #1e0812, inset 0px 3px 2px #fafafa"
