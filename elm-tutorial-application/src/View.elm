module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (..)
import Models exposing (..)
import Players.List


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    Players.List.view model.players
