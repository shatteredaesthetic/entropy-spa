module Game.Board.View exposing (view, cellOuterWrap, cellBtnWrap)

import Html exposing (..)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Util.Types exposing (..)
import Util.View exposing (..)
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
                |> boardWrap []
    in
        boardViewWrap [] [ boardView ]


cellView : Cell -> Html Action
cellView cell =
    cellOuterWrap cell.highlight
        [ onClick (Choose cell.x cell.y) ]
        [ cellBtnWrap cell.colour [] [] ]


makeBoardRow : Matrix (Html Action) -> Int -> Html Action
makeBoardRow board y =
    Matrix.getRow y board
        |> Maybe.map Array.toList
        |> Maybe.withDefault []
        |> rowWrap []


boardWrap : StyledComponent
boardWrap =
    styled div
        [ display flex_
        , width (vh 70)
        , height (vh 70)
        ]


boardViewWrap : StyledComponent
boardViewWrap =
    styled div
        [ display flex_
        , alignItems flexEnd
        , justifyContent center
        , flex (int 3) (int 0) (percent 75)
        , backgroundColor (hex "1c1c38")
        ]


cellBtnWrap : Colour -> StyledComponent
cellBtnWrap col =
    styled div
        [ width (percent 90)
        , height (percent 90)
        , boxSizing borderBox
        , borderRadius (px 5)
        , backgroundColor (hex <| getHexColor col)
        ]


cellOuterWrap : Bool -> StyledComponent
cellOuterWrap hghlgt =
    styled centerWrap <|
        List.concat
            [ [ flex (int 1) (int 0) auto
              , borderRadius (px 4)
              , backgroundColor (hex "1c1c38")
              , border (px 1) solid (hex "777f91")
              ]
            , highlightStyle hghlgt
            ]


rowWrap : StyledComponent
rowWrap =
    styled columnWrap [ flex (int 1) (int 0) auto ]


highlightStyle : Bool -> List Rule
highlightStyle hghlgt =
    case hghlgt of
        True ->
            [ backgroundColor (hex "faf9f9") ]

        False ->
            []
