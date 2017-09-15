module Game.Board.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Util.Types exposing (..)
import Util.View exposing (..)
import Game.Board.Styles exposing (..)


{ id, class, classList } =
    boardNS


view : Matrix Cell -> Html Action
view board =
    let
        newBoard =
            Matrix.map cellView board

        boardView =
            List.range 0 4
                |> List.map (makeBoardRow newBoard)
                |> div [ id GameInner ]

        contStyle =
            [ "padding" => "5px 0px 5 px 0px" ]
    in
        div
            [ id GameContainer ]
            [ boardView ]


cellView : Cell -> Html Action
cellView cell =
    div
        [ class BoardCell
        , style <| highlightStyle cell
        , onClick (Choose cell.x cell.y)
        ]
        [ div
            [ class CellBtn
            , style <| [ (=>) "background" <| String.cons '#' <| getHexColor cell.colour ]
            ]
            []
        ]


makeBoardRow : Matrix (Html Action) -> Int -> Html Action
makeBoardRow board y =
    Matrix.getRow y board
        |> Maybe.map Array.toList
        |> Maybe.withDefault []
        |> div [ class BoardRow ]
