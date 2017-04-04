module Game.Board.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Board.Styles exposing (..)


view : Matrix Cell -> Html Action
view board =
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
            [ "padding" => "5px 0px 5 px 0px" ]
    in
        div
            [ styleList [ flexStyle, centerStyle, flex 4 0, bgColor "#1e0812" ] ]
            [ boardView ]


cellView : Cell -> Html Action
cellView cell =
    let
        bgStyle =
            bgColor <| getHexColor cell.colour

        outerStyle =
            styleList [ flexStyle, centerStyle, rel, tileStyle, highlightStyle cell, flex 1 0 ]
    in
        div
            [ class "board-cell"
            , outerStyle
            , onClick (Choose cell.x cell.y)
            ]
            [ div
                [ class "cell-btn"
                , styleList [ cellBtnStyle, bgStyle ]
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
            , styleList [ flexStyle, columnStyle, flex 1 0 ]
            ]
