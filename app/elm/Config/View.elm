module Config.View exposing (configUI)

import Html exposing (Html, label, div, h1, h2, h3, text, p, a, input)
import Html.Attributes exposing (style, id, for, name, href, value, type_)
import Html.Events exposing (onInput)
import Util.Types exposing (..)
import Util.View exposing (..)
import Config.Styles exposing (..)
import Ctrl.View exposing (configBtn)


configUI : ConfigState -> Html Action
configUI state =
    div
        [ id "config-outer-container"
        , styleList [ flexStyle, centerStyle, stretchStyle ]
        ]
        [ div
            [ id "config-container"
            , styleList [ flexStyle, columnStyle, ht "100%", wd "70%", jcStyle "space-around", aiStyle "stretch" ]
            ]
            [ div [ styleList [ flexStyle, centerStyle, flex 2 0, titleStyle ] ] [ text "Entropy" ]
            , namesPanel state
            , configBtn
            , instPanel
            ]
        ]


namesPanel : ConfigState -> Html Action
namesPanel state =
    div
        [ id "config-top-panel"
        , styleList [ flexStyle, aiStyle "center", jcStyle "space-around", bgColor "#d8d8d8", flex 3 0 ]
        ]
        [ div
            [ id "player-config-panel"
            , styleList [ flexStyle, centerStyle, columnStyle ]
            ]
            [ label
                [ for "player1-name"
                , style labelStyle
                ]
                [ text "Player 1:" ]
            , input
                [ type_ "text"
                , name "player1-name"
                , onInput SetPlayer1
                , value state.player1name
                ]
                []
            ]
        , div
            [ id "player-config-panel"
            , styleList [ flexStyle, centerStyle, columnStyle ]
            ]
            [ label
                [ for "player2-name"
                , style labelStyle
                ]
                [ text "Player 2:" ]
            , input
                [ type_ "text"
                , name "player2-name"
                , onInput SetPlayer2
                , value state.player2name
                ]
                []
            ]
        ]


instPanel : Html Action
instPanel =
    div
        [ id "config-instructions"
        , styleList [ flexStyle, columnStyle, bgColor "#d8d8d8", flex 4 0 ]
        ]
        [ h3
            [ id "config-instructions-link" ]
            [ text "From "
            , a
                [ style anchorStyle
                , href "https://boardgamegeek.com/boardgame/1329/hyle"
                ]
                [ text "BoardGameGeek" ]
            ]
        , instructions
        ]


instructions : Html Action
instructions =
    div
        [ id "config-instructions-block" ]
        [ p [] [ text "Hyle (or Entropy) is played on a board with 5x5 spaces. During each round one player (Chaos) randomly draws and places colored wooden disks on a vinyl/cloth map. After a disk is placed, the other player (Order) may move any disk on the grid horizontally or vertically in order to form palindromes (sequences of colors that run the same forward as backward, for example, red/blue/yellow/blue/red)." ]
        , p [] [ text "The game is played over two rounds (so that each player assumes each role once) and points are awarded to Order equal to the length of the palindromes formed: blue/blue=2 points, blue/red/blue=3 points, etc. (Note that blue/blue/blue is worth 7 points because it contains two 2-point palindromes and one 3-point palindrome.)" ]
        ]
