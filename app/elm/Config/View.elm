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
    cfgOuterCont []
        [ cfgCont []
            [ title [] [ text "Entropy" ]
            , namesPanel state
            , cfgBtns
            , instPanel
            ]
        ]


namesPanel : ConfigState -> Html Action
namesPanel { player1name, player2name } =
    namesCont []
        [ plyrCfg player1name SetPlayer1 "p1-name" "Player 1:"
        , plyrCfg player2name SetPlayer2 "p2-name" "Player 2:"
        ]


plyrCfg : String -> (String -> Action) -> String -> String -> Html Action
plyrCfg val msg nm lbl =
    plyrCfgCont []
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
    descCont []
        [ instInnerCont []
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


cfgOuterCont : StyledComponent
cfgOuterCont =
    styled centerWrap
        [ width (percent 100)
        , height (percent 100)
        ]


cfgCont : StyledComponent
cfgCont =
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
        , color (hex "98dafc")
        , textShadow (px 0) (px 0) (px 40) (hex "b88b64")
        , backgroundColor (hex "d8d8d8")
        , fontWeight (int 600)
        , fontSize (em 3)
        ]


namesCont : StyledComponent
namesCont =
    styled div
        [ display flex_
        , alignItems center
        , justifyContent spaceAround
        , flex (int 3) (int 0) auto
        , backgroundColor (hex "d8d8d8")
        , color (hex "312c32")
        ]


lblStyle : StyledComponent
lblStyle =
    styled label
        [ color (hex "daad86")
        , fontWeight (int 600)
        ]


plyrCfgCont : StyledComponent
plyrCfgCont =
    styled centerWrap [ flexDirection column ]


descCont : StyledComponent
descCont =
    styled columnWrap
        [ display flex_
        , justifyContent center
        , alignItems center
        , flex (int 4) (int 0) auto
        , color (hex "312c32")
        ]


instInnerCont : StyledComponent
instInnerCont =
    styled columnWrap
        [ alignItems center
        , justifyContent flexStart
        , width (percent 90)
        , backgroundColor (hex "feffff")
        , padding2 zero (Styled.rem 1)
        , boxShadow (px 1) (px 1) (px 5) (px 1) (hex "312c32")
        ]


anchComp : StyledComponent
anchComp =
    styled a [ color (hex "daad86") ]
