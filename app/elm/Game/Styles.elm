module Game.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace gameNS.name)
        [ id GameMainContainer
            [ displayFlex, stretchStyle ]
        , id GamePanel
            [ displayFlex, columnStyle, justifyContent spaceAround, flex2 (int 3) (int 0) ]
        ]


gameNS : Namespace String class id msg
gameNS =
    withNamespace "game"
