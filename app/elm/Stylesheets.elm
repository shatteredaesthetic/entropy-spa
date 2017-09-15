port module Stylesheets exposing (..)

import Css.File as File exposing (CssFileStructure, CssCompilerProgram)
import Break.Styles as Break
import Config.Styles as Config
import Ctrl.Styles as Ctrl
import Game.Styles as Game
import Game.Board.Styles as Board
import Game.Message.Styles as Message
import Game.Player.Styles as Styles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    File.toFileStructure
        [ ( "index.css"
          , File.compile
                [ Break.css
                , Config.css
                , Ctrl.css
                , Game.css
                , Board.css
                , Message.css
                , Styles.css
                ]
          )
        ]


main : CssCompilerProgram
main =
    File.compiler files fileStructure
