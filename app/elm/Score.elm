module Score exposing (..)

import Util.Types exposing (..)
import List.Extra exposing (groupsOfWithStep, groupsOf)
import Util.View exposing (tileToString)
import Matrix exposing (Matrix)
import Array exposing (Array)


type alias MatrixGetter =
    Int -> Matrix Colour -> Maybe (Array Colour)


getGroups : List a -> List (List a)
getGroups list =
    List.range 2 5
        |> List.concatMap (\n -> groupsOfWithStep n 1 list)
        |> List.filter (\l -> l == List.reverse l)


scoreGroup : String -> Int
scoreGroup section =
    section
        |> String.split ""
        |> getGroups
        |> List.foldl (\l acc -> acc + List.length l) 0


convertBoard : MatrixGetter -> Board -> List String
convertBoard f matrix =
    let
        m =
            Matrix.map (.colour >> (Maybe.withDefault Red)) matrix

        toLetter colour =
            String.left 1 <| tileToString colour

        row i =
            f i m
                |> Maybe.withDefault Array.empty
                |> Array.foldl (\col acc -> acc ++ (toLetter col)) ""
    in
        List.map row <| List.range 0 4


score : Board -> Int
score board =
    let
        f =
            (List.map scoreGroup) >> List.sum

        rows =
            (convertBoard Matrix.getRow) >> f

        cols =
            convertBoard Matrix.getColumn >> f
    in
        bigPhi (+) rows cols board


{-| bigPhi - Applies a function to the result of applying two different functions on the same input.
    >>> bigPhi (+) ((*) 3) ((*) 2) 5
    25
    >>> bigPhi String.append String.toLower String.toUpper "test"
    "testTEST"
-}
bigPhi : (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
bigPhi f g h x =
    f (g x) (h x)
