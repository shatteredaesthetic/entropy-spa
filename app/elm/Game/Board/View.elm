module Game.Board.View exposing (view, cellOuterCont, cellBtnCont)

import Html exposing (..)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Util.Types exposing (..)
import Util.View exposing (getHexColor)
import Styled exposing (..)
import Styled.Types exposing (Rule)


view : Matrix Cell -> Html Action
view board =
    let
        newBoard =
            Matrix.map cellView board

        boardView =
            List.range 0 4
                |> List.map (makeBoardRow newBoard)
                |> boardCont []
    in
        boardViewCont [] [ boardView ]


cellView : Cell -> Html Action
cellView cell =
    cellOuterCont cell.highlight
        [ onClick (Choose cell.x cell.y) ]
        [ cellBtnCont cell.colour [] [] ]


makeBoardRow : Matrix (Html Action) -> Int -> Html Action
makeBoardRow board y =
    Matrix.getRow y board
        |> Maybe.map Array.toList
        |> Maybe.withDefault []
        |> rowCont []


boardCont : StyledComponent
boardCont =
    styled div
        [ display flex_
        , width (vh 70)
        , height (vh 70)
        ]


boardViewCont : StyledComponent
boardViewCont =
    styled div
        [ display flex_
        , justifyContent center
        , alignContent center
        , flex (int 4) (int 0) auto
        , backgroundColor (hex "1e0812")
        ]


cellBtnCont : Colour -> StyledComponent
cellBtnCont col =
    styled div
        [ width (percent 90)
        , height (percent 90)
        , boxSizing borderBox
        , borderRadius (px 5)
        , backgroundColor (hex <| getHexColor col)
        ]


cellOuterCont : Bool -> StyledComponent
cellOuterCont hghlgt =
    styled div <|
        List.concat
            [ [ display flex_
              , justifyContent center
              , alignItems center
              , flex (int 1) (int 0) auto
              , borderRadius (px 4)
              , backgroundColor (hex "1e0812")
              , border (px 1) solid (hex "8d8d8d")
              ]
            , highlightStyle hghlgt
            ]


rowCont : StyledComponent
rowCont =
    styled div
        [ display flex_
        , flexDirection column
        , flex (int 1) (int 0) auto
        ]


highlightStyle : Bool -> List Rule
highlightStyle hghlgt =
    case hghlgt of
        True ->
            [ backgroundColor (hex "f4fc14") ]

        False ->
            []
