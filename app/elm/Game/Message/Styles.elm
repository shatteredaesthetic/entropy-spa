module Game.Message.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Util.Types exposing (..)
import Util.View exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace messageNS.name)
        [ id MsgPanel
            [ displayFlex, centerStyle, footerStyle, bgColor "1e0812", flex2 (int 1) (int 0) ]
        ]


messageNS : Namespace String class id msg
messageNS =
    withNamespace "message"


footerStyle : Mixin
footerStyle =
    mixin
        [ txtCol "fafafa"
        , fontFamily monospace
        , boxShadow6 inset (px 0) (px 3) (px 3) (px 0) (hex "d8d8d8")
        ]
