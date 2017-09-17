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
p1Header { turn, player1, tiles } =
    plyrWrap
        [ class "p1-container" ]
        [ plyrTopWrap []
            [ tokenWrap [] [ playerToken turn player1 ]
            , nameWrap [] [ text <| String.left 7 player1.name ]
            , scoreWrap [] [ text <| toString player1.score ]
            ]
        , plyrBottomWrap []
            [ centered [] [ selectedCellView <| currColourL.get tiles ] ]
        ]


p2Header : InGameState -> Html Action
p2Header { turn, player2 } =
    plyrWrap
        [ class "p2-container" ]
        [ plyrTopWrap []
            [ tokenWrap [] [ playerToken turn player2 ]
            , nameWrap [] [ text player2.name ]
            , scoreWrap [] [ text <| toString player2.score ]
            ]
        , plyrBottomWrap []
            [ gameBtns ]
        ]


selectedCellView : Colour -> Html Action
selectedCellView colour =
    cellOuterWrap False [] [ cellBtnWrap colour [] [] ]


playerToken : Role -> Player -> Html Action
playerToken role player =
    let
        token =
            case player.role of
                Chaos ->
                    "C"

                Order ->
                    "O"
    in
        centered [] [ outerWrap [] [ tokenInner role player [] [ text token ] ] ]


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
        , backgroundColor (hex "1c1c38")
        ]


nameWrap : StyledComponent
nameWrap =
    styled centerWrap
        [ flex (int 2) (int 0) (percent 30)
        , color (hex "1c1c38")
        , fontSize (em 5)
        , backgroundColor (hex "faf9f9")
        , textShadow zero zero (px 15) (hex "777f91")
        ]


scoreWrap : StyledComponent
scoreWrap =
    styled centerWrap
        [ flex (int 1) (int 0) (percent 30)
        , color (hex "faf9f9")
        , backgroundColor (hex "1c1c38")
        , textShadow zero zero (px 20) (hex "224f75")
        , fontSize (em 7)
        ]


plyrWrap : StyledComponent
plyrWrap =
    styled columnWrap
        [ flex (int 1) (int 0) auto
        , backgroundColor (hex "777f91")
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
        , backgroundColor (hex "777f91")
        ]


tokenInner : Role -> Player -> StyledComponent
tokenInner role plyr =
    styled div <|
        List.concat
            [ [ display flex_
              , flex (int 1) (int 0) auto
              , color (hex "224f75")
              , padding (px 5)
              , fontSize (em 9)
              , fontWeight (int 700)
              , boxSizing borderBox
              , border (px 5) solid (hex "1c1c38")
              , backgroundColor (hex "1c1c38")
              ]
            , (if role == plyr.role then
                [ textShadow zero zero (px 20) (hex "faf9f9")
                , border (px 1) dashed (hex "870d3a")
                , borderRadius (percent 30)
                ]
               else
                []
              )
            ]


outerWrap : StyledComponent
outerWrap =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        ]



--
--
-- #231123          #353535          #5dfdcb          #0b132b          #faf9f9          #fffdff          #e2530b
-- #82204a          #3c6e71          #7cc6fe          #1c2541          #777f91          #ac4b45          #efe8de
-- #558c8c          #ffffff          #f4faff          #3a506b          #224f75          #30834f          #d6d5d4
-- #e8db7d          #d9d9d9          #8789c0          #5bc0be          #870d3a          #47454a          #ffffff
-- #eff7ff          #284b63          #08090a          #ffffff          #1c1c38          #35302a          #575655
--
--
