module Break.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace breakNS.name)
        [ id BreakContainer
            [ displayFlex, stretchStyle ]
        , id MiddlePanel
            [ displayFlex, columnStyle ]
        , id BoardPanel
            [ displayFlex, centerStyle, height (pct 70) ]
        , class PlayerPanel
            [ displayFlex, columnStyle, width (pct 25) ]
        ]


breakNS : Namespace String class id msg
breakNS =
    withNamespace "break"
