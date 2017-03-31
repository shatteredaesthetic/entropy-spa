module Break.Score exposing (convertMatrix, scoreBoard)

import Json.Decode as JD
import Json.Encode as JE
import Array exposing (Array)
import Util.Types exposing (..)
import Matrix exposing (Matrix)
import String
import Util.View exposing (tileToString)
import Http


apiUrl : String
apiUrl =
    "http://localhost:4000/api/score"


type alias MatrixGetter =
    Int -> Matrix Colour -> Maybe (Array Colour)


convertMatrix : MatrixGetter -> Matrix Cell -> String
convertMatrix f matrix =
    let
        m =
            Matrix.map (\cell -> cell.colour |> Maybe.withDefault Red) matrix

        toLetter colour =
            String.left 1 <| tileToString colour

        row i =
            f i m
                |> Maybe.withDefault Array.empty
                |> Array.foldl (\col acc -> acc ++ (toLetter col)) ""
    in
        List.range 0 4
            |> List.foldl (\num acc -> String.append acc <| row num) ""


encodeBoards : Matrix Cell -> Int -> Http.Body
encodeBoards matrix rnd =
    let
        rows =
            convertMatrix Matrix.getRow

        cols =
            convertMatrix Matrix.getColumn
    in
        JE.object
            [ ( "rows", JE.string <| rows matrix )
            , ( "cols", JE.string <| cols matrix )
            , ( "round", JE.int rnd )
            ]
            |> Http.jsonBody


scoreBoard : Matrix Cell -> Int -> Cmd Action
scoreBoard matrix rnd =
    let
        scoreDecoder =
            JD.map2 ScoreReturn
                (JD.field "score" JD.int)
                (JD.field "round" JD.int)
    in
        Http.post apiUrl (encodeBoards matrix rnd) scoreDecoder
            |> Http.send ScoreChaos
