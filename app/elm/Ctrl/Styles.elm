module Ctrl.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace ctrlNS.name)
        [ id GameBtns
            [ displayFlex, centerStyle, columnStyle, stretchStyle ]
        , id BreakBtns
            [ displayFlex, stretchStyle, justifyContent spaceAround, alignItems center ]
        , id ConfigBtn
            [ displayFlex, centerStyle, bgColor "d8d8d8", flex2 (int 1) (int 0) ]
        , id StartBtn
            [ btnStyle, styledBtnStyle ]
        , class BtnBase
            [ btnStyle ]
        ]


ctrlNS : Namespace String class id msg
ctrlNS =
    withNamespace "ctrl"
