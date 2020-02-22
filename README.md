# torus-puzzle-elm

Torus puzzle web app in [Elm][elm]

## Instructions

We will assume this project exists locally and we are logged into a shell where
the root of the project is the working directory.

We will also assume [Elm][elm] version 0.19.1 is installed.

### View Web App

View the web app by completing the following steps
1. compile the main module and
2. navigate to the [web app][app] in a web browser.

We can compile the main module by running the following command

    > elm make src/Main.elm --output=app/main.js

### Solve Puzzle

When the web app is initially loaded, all of the puzzle pieces will be in the
completed position. The picture used for this puzzle is of my dog, Gabriel.
Isn't he cute?

The puzzle pieces can be shuffled by clicking on the "shuffle" button.

The rows and columns of the puzzle can be cycled by clicking on the arrow
buttons (&#x25b2;, &#x25b6;, &#x25bc;, &#x25c0;). The puzzle may look like
a square but it is actually a torus!

### Test

We will assume [Node.js][node] and [elm-test][test] are installed. Run the tests
with `elm-test` command.

[elm]: https://elm-lang.org
[format]: https://github.com/avh4/elm-format

[node]: https://nodejs.org
[test]: https://www.npmjs.com/package/elm-test

[app]: app/index.html
