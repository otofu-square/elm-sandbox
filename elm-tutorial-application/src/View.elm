module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
