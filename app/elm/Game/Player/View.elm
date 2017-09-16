module Game.Player.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, class)
import Game.Board.View exposing (cellBtnCont, cellOuterCont)
import Util.Types exposing (..)
import Util.View exposing (..)
import Util.Lenses exposing (..)
import Ctrl.View exposing (gameBtns)
import Styled exposing (..)


p1Header : InGameState -> Html Action
p1Header { player1, tiles } =
    plyrCont
        [ class "p1-container" ]
        [ plyrTopCont []
            [ tokenCont [] [ playerToken player1 ]
            , nameCont [] [ text player1.name ]
            , scoreCont [] [ text <| toString player1.score ]
            ]
        , plyrBottomCont []
            [ centered [] [ selectedCellView <| currColourL.get tiles ] ]
        ]


p2Header : InGameState -> Html Action
p2Header { player2 } =
    plyrCont
        [ class "p2-container" ]
        [ plyrTopCont []
            [ tokenCont [] [ playerToken player2 ]
            , nameCont [] [ text player2.name ]
            , scoreCont [] [ text <| toString player2.score ]
            ]
        , plyrBottomCont []
            [ gameBtns ]
        ]


selectedCellView : Colour -> Html Action
selectedCellView colour =
    cellOuterCont False [] [ cellBtnCont colour [] [] ]


playerToken : Player -> Html Action
playerToken player =
    let
        token =
            case player.role of
                Chaos ->
                    "C"

                Order ->
                    "O"
    in
        centered [] [ outerCont [] [ tokenUI [] [ text token ] ] ]


plyrTopCont : StyledComponent
plyrTopCont =
    styled columnWrap
        [ flex (int 5) (int 0) auto
        , alignContent flexStart
        , alignItems stretch
        , border (px 2) solid (hex "00aa00")
        ]


tokenCont : StyledComponent
tokenCont =
    styled centerWrap
        [ flex (int 3) (int 0) (percent 40)
        , border (px 2) solid (hex "aa0000")
        , backgroundColor (hex "1e0812")
        ]


nameCont : StyledComponent
nameCont =
    styled centerWrap
        [ flex (int 2) (int 0) (percent 30)
        , color (hex "1e0812")
        , fontSize (em 5)
        , backgroundColor (hex "d8d8d8")
        , textShadow zero zero (px 15) (hex "727272")
        ]


scoreCont : StyledComponent
scoreCont =
    styled centerWrap
        [ flex (int 1) (int 0) (percent 30)
        , color (hex "fafafa")
        , backgroundColor (hex "1e0812")
        , textShadow zero zero (px 20) (hex "b61e64")
        , fontSize (em 7)
        , border (px 2) solid (hex "0000aa")
        ]


plyrCont : StyledComponent
plyrCont =
    styled columnWrap
        [ flex (int 1) (int 0) auto
        , backgroundColor (hex "d8d8d8")
        ]


currTile : Colour -> StyledComponent
currTile curr =
    styled div
        [ width (percent 80)
        , height (percent 80)
        , backgroundColor <| hex <| getHexColor curr
        ]


centered : StyledComponent
centered =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        , width (percent 50)
        , height (percent 50)
        ]


plyrBottomCont : StyledComponent
plyrBottomCont =
    styled div
        [ display flex_
        , flex (int 2) (int 0) auto
        , alignContent flexEnd
        , justifyContent center
        , alignItems center
        , backgroundColor (hex "727272")
        ]


tokenUI : StyledComponent
tokenUI =
    styled div
        [ display flex_
        , flex (int 1) (int 0) auto
        , color (hex "b61e64")
        , padding (px 5)
        , fontSize (em 9)
        , fontWeight (int 700)
        , boxSizing borderBox
        , border (px 5) solid (hex "1e0812")
        , backgroundColor (hex "1e0812")
        , textShadow zero zero (px 10) (hex "fafafa")
        ]


outerCont : StyledComponent
outerCont =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        ]
