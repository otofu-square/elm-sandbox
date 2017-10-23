module Main exposing (..)

import Commands exposing (..)
import Html exposing (Html, div, program, text)
import Models exposing (..)
import Msgs exposing (..)
import Navigation exposing (Location)
import Routing
import Update exposing (..)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
    ( initialModel currentRoute, fetchPlayers )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
