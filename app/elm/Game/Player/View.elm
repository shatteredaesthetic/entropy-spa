module Game.Player.View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, class)
import Game.Board.View exposing (cellBtnWrap, cellOuterWrap)
import Util.Types exposing (..)
import Util.View exposing (..)
import Util.Lenses exposing (..)
import Ctrl.View exposing (gameBtns)
import Styled exposing (..)


p1Header : InGameState -> Html Action
p1Header { player1, tiles } =
    plyrWrap
        [ class "p1-container" ]
        [ plyrTopWrap []
            [ tokenWrap [] [ playerToken player1 ]
            , nameWrap [] [ text <| String.left 7 player1.name ]
            , scoreWrap [] [ text <| toString player1.score ]
            ]
        , plyrBottomWrap []
            [ centered [] [ selectedCellView <| currColourL.get tiles ] ]
        ]


p2Header : InGameState -> Html Action
p2Header { player2 } =
    plyrWrap
        [ class "p2-container" ]
        [ plyrTopWrap []
            [ tokenWrap [] [ playerToken player2 ]
            , nameWrap [] [ text player2.name ]
            , scoreWrap [] [ text <| toString player2.score ]
            ]
        , plyrBottomWrap []
            [ gameBtns ]
        ]


selectedCellView : Colour -> Html Action
selectedCellView colour =
    cellOuterWrap False [] [ cellBtnWrap colour [] [] ]


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
        centered [] [ outerWrap [] [ tokenUI [] [ text token ] ] ]


plyrTopWrap : StyledComponent
plyrTopWrap =
    styled columnWrap
        [ flex (int 4) (int 0) auto
        , alignContent flexStart
        , alignItems stretch
        ]


tokenWrap : StyledComponent
tokenWrap =
    styled centerWrap
        [ flex (int 3) (int 0) (percent 40)
        , backgroundColor (hex "312c32")
        ]


nameWrap : StyledComponent
nameWrap =
    styled centerWrap
        [ flex (int 2) (int 0) (percent 30)
        , color (hex "312c32")
        , fontSize (em 5)
        , backgroundColor (hex "feffff")
        , textShadow zero zero (px 15) (hex "98dafc")
        ]


scoreWrap : StyledComponent
scoreWrap =
    styled centerWrap
        [ flex (int 1) (int 0) (percent 30)
        , color (hex "feffff")
        , backgroundColor (hex "312c32")
        , textShadow zero zero (px 20) (hex "daad86")
        , fontSize (em 7)
        ]


plyrWrap : StyledComponent
plyrWrap =
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


plyrBottomWrap : StyledComponent
plyrBottomWrap =
    styled div
        [ display flex_
        , flex (int 2) (int 0) auto
        , alignContent flexEnd
        , justifyContent center
        , alignItems center
        , backgroundColor (hex "daad86")
        ]


tokenUI : StyledComponent
tokenUI =
    styled div
        [ display flex_
        , flex (int 1) (int 0) auto
        , color (hex "98dafc")
        , padding (px 5)
        , fontSize (em 9)
        , fontWeight (int 700)
        , boxSizing borderBox
        , border (px 5) solid (hex "312c32")
        , backgroundColor (hex "312c32")
        , textShadow zero zero (px 10) (hex "feffff")
        ]


outerWrap : StyledComponent
outerWrap =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        ]
