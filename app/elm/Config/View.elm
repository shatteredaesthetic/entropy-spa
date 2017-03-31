module Config.View exposing (configUI)

import Html exposing (Html, Attribute, label, div, h1, h2, h3, text, p, a, input)
import Html.Attributes exposing (style, class, for, name, href, type_)
import Html.Events exposing (onInput, onClick)
import Util.Types exposing (..)
import Util.View exposing (..)
import Config.Styles exposing (..)


configUI : ConfigState -> Html Action
configUI cfg =
    div
        [ class "config-container"
        , styleList [ flexStyle, stretchStyle, columnStyle ]
        ]
        [ header cfg
        , div
            [ class "config-instructions"
            , styleList [ flexStyle, columnStyle, (flex 1 0) ]
            ]
            [ h3
                [ class "config-instructions-link" ]
                [ text "From "
                , a
                    [ style anchorStyle
                    , href "https://boardgamegeek.com/boardgame/1329/hyle"
                    ]
                    [ text "BoardGameGeek" ]
                ]
            , instructions
            ]
        ]


header : ConfigState -> Html Action
header cfg =
    div
        [ class "config-top-container"
        , styleList [ flexStyle, columnStyle, topContainerStyle, (flex 3 0) ]
        ]
        [ div
            [ class "config-form"
            , styleList [ flexStyle, jcsbStyle, (flex 1 0) ]
            ]
            [ div
                [ class "config-leftside"
                , styleList [ flexStyle, centerStyle, columnStyle, alignStyle, (flex 2 0) ]
                ]
                [ label
                    [ for "player1-name"
                    , style labelStyle
                    ]
                    [ text "Player 1 Name:" ]
                , input
                    [ type_ "text"
                    , name "player1-name"
                    , onInput SetPlayer1
                    ]
                    []
                ]
            , div
                [ class "config-centerside"
                , styleList [ flexStyle, centerBtnStyle, columnStyle, (flex 1 0) ]
                ]
                [ h2 [ styleList [ flexStyle, centerStyle ] ] [ text "Entropy" ]
                , div
                    [ class "game-start-btn"
                    , styleList [ flexStyle, centerStyle, btnStyle, styledBtnStyle ]
                    , onClick StartGame
                    ]
                    [ text "Start Game" ]
                ]
            , div
                [ class "config-rightside"
                , styleList [ flexStyle, centerStyle, columnStyle, alignStyle, (flex 2 0) ]
                ]
                [ label
                    [ for "player2-name"
                    , style labelStyle
                    ]
                    [ text "Player 2 Name:" ]
                , input
                    [ type_ "text"
                    , name "player2-name"
                    , onInput SetPlayer2
                    ]
                    []
                ]
            ]
        ]


instructions : Html Action
instructions =
    div
        [ class "config-instructions-block" ]
        [ p [] [ text "Hyle (or Entropy) is played on a board with 5x5 spaces. During each round one player (Chaos) randomly draws and places colored wooden disks on a vinyl/cloth map. After a disk is placed, the other player (Order) may move any disk on the grid horizontally or vertically in order to form palindromes (sequences of colors that run the same forward as backward, for example, red/blue/yellow/blue/red)." ]
        , p [] [ text "The game is played over two rounds (so that each player assumes each role once) and points are awarded to Order equal to the length of the palindromes formed: blue/blue=2 points, blue/red/blue=3 points, etc. (Note that blue/blue/blue is worth 7 points because it contains two 2-point palindromes and one 3-point palindrome.)" ]
        ]
