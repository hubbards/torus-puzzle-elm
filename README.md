# torus-puzzle-elm

Torus puzzle web app in [Elm][elm]

## Puzzle Instructions

When the web app is initially loaded, all of the puzzle pieces will be in the
completed position. The picture used for this puzzle is of my dog, Gabriel.
Isn't he cute?

The puzzle pieces can be shuffled by clicking on the "shuffle" button.

The rows and columns of the puzzle can be cycled by clicking on the arrow
buttons. This puzzle may look like a square but it is actually a torus!

## Development Instructions

We will assume that this project exists locally and we are logged into a shell
where the root of the project is the working directory.

We will also assume that [Elm][elm] is installed.

### Install External Dependencies

Download external packages with the `elm-package install` command.

### View Web App

View the web app by completing the following steps
1. compile the main module and
2. navigate to the web app in a web browser.

We can compile the main module by running the following command

```
elm-make src/Main.elm --output=public/elm.js
```

[elm]: http://elm-lang.org/
[test]: https://github.com/elm-community/elm-test
[git]: https://git-scm.com/
