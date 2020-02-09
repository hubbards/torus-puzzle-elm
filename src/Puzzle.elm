module Puzzle exposing
    ( Cycle
    , Dir(..)
    , Grid
    , Puzzle
    , Tile
    , cycle
    , make
    )

{-| TODO document
-}

import List.Extra


{-| Record for puzzles. A puzzle consists of a rectangular grid of tiles.
-}
type alias Puzzle =
    { numRows : Int
    , numCols : Int
    , grid : Grid
    }


{-| Type alias for grids of tiles. A grid consists of a list of lists of tiles
where each element of the outer list represents a row of tiles.
-}
type alias Grid =
    List (List Tile)


{-| Type alias for puzzle pieces (or tiles). A tile is identified by the
zero-based row and column indices of its completed position in the puzzle.
-}
type alias Tile =
    ( Int, Int )


{-| Makes a puzzle with a given number of rows and columns where each tile is
in the completed position.
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


{-| Type synonym for cycles. A cycle is a pair of direction and row or column
index. If the direction is `North` or `South`, then the index is considered a
column index. If the direction is `East` or `West`, then the index is considered
a row index.
-}
type alias Cycle =
    ( Dir, Int )


{-| Data type for cardinal directions.
-}
type Dir
    = North
    | South
    | East
    | West


{-| Cycle the tiles of a grid in a given row or column by one unit in a given
direction.
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
