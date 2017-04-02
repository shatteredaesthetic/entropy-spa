module Board.View exposing (gameView, board)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Util.Types exposing (..)
import Util.View exposing (..)
import Board.Styles exposing (..)


gameView : InGameState -> Html Action
gameView state =
    div
        [ class "game-container"
        , styleList [ flexStyle, columnStyle, stretchStyle ]
        ]
        [ header state
        , board state.board
        ]


header : InGameState -> Html Action
header state =
    div
        [ class "game-header"
        , styleList [ flexStyle, headerStyle, (flex 1 0) ]
        ]
        [ div
            [ class "header-player1"
            , styleList [ flexStyle, (flex 1 0) ]
            ]
            [ playerToken state.player1
            , div
                [ class "player-name"
                , styleList
                    [ flexStyle
                    , playerNameStyle
                    , (flex 2 0)
                    , [ "justify-content" => "flex-start", "padding-left" => "20px" ]
                    ]
                ]
                [ text state.player1.name ]
            ]
        , div
            [ class "selected-tile"
            , styleList [ flexStyle, centerStyle, (flex 1 0) ]
            ]
            [ div
                [ style <| currentTileStyle state ]
                []
            ]
        , div
            [ class "header-player2"
            , styleList [ flexStyle, (flex 1 0) ]
            ]
            [ div
                [ class "player-name"
                , styleList
                    [ flexStyle
                    , playerNameStyle
                    , (flex 2 0)
                    , [ "justify-content" => "flex-end", "padding-right" => "20px" ]
                    ]
                ]
                [ text state.player2.name ]
            , playerToken state.player2
            ]
        ]


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
        div
            [ class "token-container"
            , styleList [ flexStyle, centerStyle ]
            ]
            [ div
                [ class "player-token"
                , styleList [ tokenStyle, (flex 1 0) ]
                ]
                [ text token ]
            ]


board : Matrix Cell -> Html Action
board board =
    let
        newBoard =
            Matrix.map cellView board

        boardView =
            List.range 0 4
                |> List.map (makeBoardRow newBoard)
                |> div
                    [ class "game-board-container"
                    , styleList [ flexStyle, boardContainerStyle ]
                    ]

        contStyle =
            [ "background" => "#8d8d8d"
            , "padding" => "5px 0px 5 px 0px"
            ]
    in
        div
            [ styleList [ flexStyle, centerStyle, contStyle ] ]
            [ boardView ]


cellView : Cell -> Html Action
cellView cell =
    let
        bgColor =
            case cell.colour of
                Nothing ->
                    [ ( "background", "#1e0812" ) ]

                Just colour ->
                    [ ( "background", getHexColor colour ) ]

        sizeStyle =
            styleList [ flexStyle, centerStyle, tileStyle, (highlightStyle cell), (flex 1 0) ]
    in
        div
            [ class "board-cell"
            , sizeStyle
            , onClick (Choose cell.x cell.y)
            ]
            [ div
                [ class "cell-btn"
                , styleList [ cellBtnStyle, bgColor ]
                ]
                []
            ]


makeBoardRow : Matrix (Html Action) -> Int -> Html Action
makeBoardRow board y =
    Matrix.getRow y board
        |> Maybe.map Array.toList
        |> Maybe.withDefault []
        |> div
            [ class "board-row"
            , styleList [ flexStyle, columnStyle, (flex 1 0) ]
            ]
