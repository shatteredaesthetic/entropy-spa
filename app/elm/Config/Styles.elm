module Config.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace configNS.name)
        [ id OuterContainer
            [ displayFlex, centerStyle, stretchStyle ]
        , id InnerContainer
            [ displayFlex, columnStyle, height (pct 100), width (pct 70), justifyContent spaceAround, alignItems stretch ]
        , id GameTitle
            [ displayFlex, centerStyle, flex2 (int 2) (int 0), txt, bgColor "d8d8d8", boldF, fontSize (em 3) ]
        , id InstructionPanel
            [ displayFlex, columnStyle, bgColor "d8d8d8", txtCol "1e0812", flex2 (int 4) (int 0) ]
        , id InstructionAnchor
            [ txt, textDecoration none ]
        , id TopPanel
            [ displayFlex, alignItems center, justifyContent spaceAround, bgColor "d8d8d8", flex2 (int 3) (int 0) ]
        , class PlyrConfigPanel
            [ displayFlex, centerStyle, columnStyle ]
        , class PlyrConfigLabel
            [ txt, boldF ]
        ]


configNS : Namespace String class id msg
configNS =
    withNamespace "config"


boldF : Mixin
boldF =
    fontWeight bold


txt : Mixin
txt =
    txtCol "b61e64"
