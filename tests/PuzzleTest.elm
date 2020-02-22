module PuzzleTest exposing (suite)

{-| TODO document
-}

import Expect
import Puzzle
import Test


{-| Unit test suite for Puzzle module.
-}
suite : Test.Test
suite =
    Test.describe "Puzzle" [ make ]



-- TODO add more tests


make : Test.Test
make =
    Test.describe "make"
        [ Test.test "make 0 0" <|
            \_ ->
                Expect.all
                    [ Expect.equal 0 << .numRows
                    , Expect.equal 0 << .numCols
                    , Expect.equal True << List.isEmpty << .grid
                    ]
                    (Puzzle.make 0 0)
        , Test.test "make 2 3" <|
            \_ ->
                Expect.all
                    [ Expect.equal 2 << .numRows
                    , Expect.equal 3 << .numCols
                    , Expect.equal 2 << List.length << .grid

                    -- TODO: map tests over rows
                    , Expect.equal 3
                        << List.length
                        << Maybe.withDefault []
                        << List.head
                        << .grid
                    , Expect.equal 3
                        << List.length
                        << Maybe.withDefault []
                        << List.head
                        << Maybe.withDefault []
                        << List.tail
                        << .grid
                    ]
                    (Puzzle.make 2 3)
        ]
