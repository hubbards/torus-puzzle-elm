module Main exposing (main)

{-| This is a web app for a torus puzzle. It is also an example of using the Elm
architecture to implement a web app.
-}

import Browser
import Html
import Html.Attributes
import Html.Events
import Puzzle
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- Model


{-| Model for torus puzzle.
-}
type alias Model =
    Puzzle.Puzzle


{-| Initial model and command for torus puzzle.
-}
init : () -> ( Model, Cmd Msg )
init _ =
    let
        numRows =
            4

        numCols =
            4
    in
    ( Puzzle.make numRows numCols, Cmd.none )



-- Update


{-| Messages for torus puzzle.
-}
type Msg
    = Shuffle
    | Cycles (List Puzzle.Cycle)
    | Cycle Puzzle.Cycle


{-| Update function for torus puzzle.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Shuffle ->
            ( model, shuffle model.numRows model.numCols )

        Cycles cs ->
            ( { model | grid = List.foldl Puzzle.cycle model.grid cs }, Cmd.none )

        Cycle c ->
            ( { model | grid = Puzzle.cycle c model.grid }, Cmd.none )


shuffle : Int -> Int -> Cmd Msg
shuffle numRows numCols =
    let
        num =
            30

        -- or use Random.Extra.bool
        bool =
            Random.uniform True [ False ]

        cycle =
            Random.andThen
                (\b ->
                    if b then
                        row

                    else
                        col
                )
                bool

        row =
            Random.pair
                (Random.map
                    (\b ->
                        if b then
                            Puzzle.East

                        else
                            Puzzle.West
                    )
                    bool
                )
                (Random.int 0 <| numRows - 1)

        col =
            Random.pair
                (Random.map
                    (\b ->
                        if b then
                            Puzzle.North

                        else
                            Puzzle.South
                    )
                    bool
                )
                (Random.int 0 <| numCols - 1)
    in
    Random.generate Cycles (Random.list num cycle)



-- Subscriptions


{-| Subscriptions for torus puzzle.
-}
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


{-| View function for torus puzzle.
-}
view : Model -> Html.Html Msg
view model =
    Html.div
        [ Html.Attributes.id "torus-puzzle" ]
        [ cyclePanel model.numCols Puzzle.North
        , cyclePanel model.numRows Puzzle.West
        , viewGrid model.grid
        , cyclePanel model.numRows Puzzle.East
        , cyclePanel model.numCols Puzzle.South
        , shuffleButton
        ]


cyclePanel : Int -> Puzzle.Dir -> Html.Html Msg
cyclePanel num dir =
    Html.div
        [ Html.Attributes.classList
            [ ( "cycle-panel", True )
            , ( "horizontial", dir == Puzzle.North || dir == Puzzle.South )
            , ( "vertical", dir == Puzzle.East || dir == Puzzle.West )
            ]
        ]
    <|
        List.map (cycleButton dir) <|
            List.range 0 (num - 1)


cycleButton : Puzzle.Dir -> Int -> Html.Html Msg
cycleButton dir i =
    let
        label =
            case dir of
                Puzzle.North ->
                    "▲"

                -- &#x25b2;
                Puzzle.South ->
                    "▼"

                -- &#x25bc;
                Puzzle.East ->
                    "▶︎"

                -- &#x25b6;
                Puzzle.West ->
                    "◀︎"

        -- &#x25c0;
    in
    Html.button
        [ Html.Events.onClick <| Cycle ( dir, i ) ]
        [ Html.text label ]


shuffleButton : Html.Html Msg
shuffleButton =
    Html.button
        [ Html.Attributes.id "shuffle-button"
        , Html.Events.onClick Shuffle
        ]
        [ Html.text "Shuffle" ]


viewGrid : Puzzle.Grid -> Html.Html msg
viewGrid =
    Html.div
        [ Html.Attributes.id "grid" ]
        << List.concatMap (List.map viewTile)


viewTile : Puzzle.Tile -> Html.Html msg
viewTile ( r, c ) =
    let
        len =
            100

        x =
            String.fromInt (-1 * c * len) ++ "px"

        y =
            String.fromInt (-1 * r * len) ++ "px"
    in
    Html.div
        [ Html.Attributes.class "tile"
        , Html.Attributes.style "backgroundPositionX" x
        , Html.Attributes.style "backgroundPositionY" y
        ]
        []
