module Puzzle exposing (..)

import List.Extra

type alias Puzzle =
  { numRows : Int
  , numCols : Int
  , grid : Grid }

type alias Grid =
  List (List Tile)

type alias Tile =
  (Int, Int)

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
    , grid = List.map makeRow rows }

type alias Cycle =
  (Dir, Int)

type Dir =
    North
  | South
  | East
  | West

cycle : Cycle -> Grid -> Grid
cycle (dir, i) =
  let
    east =
      List.reverse << west << List.reverse
    west row =
      case row of
        []        -> []
        (x :: xs) -> xs ++ [x]
  in
    case dir of
      North -> List.Extra.transpose << (List.Extra.updateAt i west) << List.Extra.transpose
      South -> List.Extra.transpose << (List.Extra.updateAt i east) << List.Extra.transpose
      East  -> List.Extra.updateAt i east
      West  -> List.Extra.updateAt i west
