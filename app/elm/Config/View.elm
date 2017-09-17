module Config.View exposing (cfgUI)

import Html exposing (Html, label, div, h1, h2, h3, text, p, a, input)
import Html.Attributes exposing (style, class, for, name, href, value, type_)
import Html.Events exposing (onInput)
import Styled exposing (..)
import Util.Types exposing (..)
import Util.View exposing (..)
import Ctrl.View exposing (cfgBtns)


cfgUI : ConfigState -> Html Action
cfgUI state =
    cfgOuterWrap []
        [ cfgWrap []
            [ title [] [ text "Entropy" ]
            , namesPanel state
            , cfgBtns
            , instPanel
            ]
        ]


namesPanel : ConfigState -> Html Action
namesPanel { player1name, player2name } =
    namesWrap []
        [ plyrCfg player1name SetPlayer1 "p1-name" "Player 1:"
        , plyrCfg player2name SetPlayer2 "p2-name" "Player 2:"
        ]


plyrCfg : String -> (String -> Action) -> String -> String -> Html Action
plyrCfg val msg nm lbl =
    plyrCfgWrap []
        [ lblStyle [ for nm ]
            [ text lbl ]
        , input
            [ type_ "text"
            , name nm
            , onInput msg
            , value val
            ]
            []
        ]


instPanel : Html Action
instPanel =
    descWrap []
        [ instInnerWrap []
            [ h3 []
                [ text "From "
                , anchComp [ href "https://boardgamegeek.com/boardgame/1329/hyle" ]
                    [ text "BoardGameGeek" ]
                ]
            , instructions
            ]
        ]


instructions : Html Action
instructions =
    div []
        [ p [] [ text "Hyle (or Entropy) is played on a board with 5x5 spaces. During each round one player (Chaos) randomly draws and places colored wooden disks on a vinyl/cloth map. After a disk is placed, the other player (Order) may move any disk on the grid horizontally or vertically in order to form palindromes (sequences of colors that run the same forward as backward, for example, red/blue/yellow/blue/red)." ]
        , p [] [ text "The game is played over two rounds (so that each player assumes each role once) and points are awarded to Order equal to the length of the palindromes formed: blue/blue=2 points, blue/red/blue=3 points, etc. (Note that blue/blue/blue is worth 7 points because it contains two 2-point palindromes and one 3-point palindrome.)" ]
        ]


cfgOuterWrap : StyledComponent
cfgOuterWrap =
    styled centerWrap
        [ width (percent 100)
        , height (percent 100)
        ]


cfgWrap : StyledComponent
cfgWrap =
    styled columnWrap
        [ height (percent 100)
        , width (percent 70)
        , justifyContent spaceAround
        , alignItems stretch
        ]


title : StyledComponent
title =
    styled centerWrap
        [ flex (int 2) (int 0) auto
        , color (hex "224f75")
        , textShadow (px 0) (px 0) (px 40) (hex "870d3a")
        , backgroundColor (hex "777f91")
        , fontWeight (int 600)
        , fontSize (em 3)
        ]


namesWrap : StyledComponent
namesWrap =
    styled div
        [ display flex_
        , alignItems center
        , justifyContent spaceAround
        , flex (int 3) (int 0) auto
        , backgroundColor (hex "777f91")
        , color (hex "1c1c38")
        ]


lblStyle : StyledComponent
lblStyle =
    styled label
        [ color (hex "870d3a")
        , fontWeight (int 600)
        , fontSize (em 1.3)
        ]


plyrCfgWrap : StyledComponent
plyrCfgWrap =
    styled centerWrap [ flexDirection column ]


descWrap : StyledComponent
descWrap =
    styled columnWrap
        [ display flex_
        , justifyContent center
        , alignItems center
        , flex (int 4) (int 0) auto
        , color (hex "1c1c38")
        ]


instInnerWrap : StyledComponent
instInnerWrap =
    styled columnWrap
        [ alignItems center
        , justifyContent flexStart
        , width (percent 90)
        , backgroundColor (hex "faf9f9")
        , padding2 zero (Styled.rem 1)
        , boxShadow (px 5) (px 5) (px 13) (px 1) (hex "1c1c38")
        ]


anchComp : StyledComponent
anchComp =
    styled a [ color (hex "870d3a") ]
