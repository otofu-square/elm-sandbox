module Main exposing (..)

import Html exposing (Html, div, program, text)
import Models exposing (..)
import Msgs exposing (..)
import Update exposing (..)
import View exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
