module Puzzle exposing (..)

{-| TODO document
-}

import List.Extra


{-| Record for a puzzle consisting of a rectangular grid of tiles
-}
type alias Puzzle =
    { numRows : Int
    , numCols : Int
    , grid : Grid
    }


{-| Type alias for a grid of tiles. Each element of the outer list represents a
row of tiles.
-}
type alias Grid =
    List (List Tile)


{-| Type alias for a puzzle piece (or tile), identified by a pair of zero-based
row and column indices.
-}
type alias Tile =
    ( Int, Int )


{-| Makes a completed puzzle with a given number of rows and columns
-}
make : Int -> Int -> Puzzle
make numRows numCols =
    let
        rows =
            List.range 0 (numRows - 1)

        cols =
            List.range 0 (numCols - 1)

        makeRow i =
            List.Extra.zip (List.repeat numCols i) cols
    in
    { numRows = numRows
    , numCols = numCols
    , grid = List.map makeRow rows
    }


{-| Type synonym for a pair of cardinal direction and row or column index. If
the direction is `North` or `South`, then the index is considered a column. If
the direction is `East` or `West`, then the index is considered a row.
-}
type alias Cycle =
    ( Dir, Int )


{-| Data type for cardinal direction
-}
type Dir
    = North
    | South
    | East
    | West


{-| Cycle the tiles of a grid in a given row or column by one unit in a given
direction
-}
cycle : Cycle -> Grid -> Grid
cycle ( dir, i ) =
    let
        east =
            List.reverse << west << List.reverse

        west row =
            case row of
                [] ->
                    []

                x :: xs ->
                    xs ++ [ x ]
    in
    case dir of
        North ->
            List.Extra.transpose << List.Extra.updateAt i west << List.Extra.transpose

        South ->
            List.Extra.transpose << List.Extra.updateAt i east << List.Extra.transpose

        East ->
            List.Extra.updateAt i east

        West ->
            List.Extra.updateAt i west
