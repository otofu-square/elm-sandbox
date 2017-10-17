module Update exposing (..)

import Models exposing (..)
import Msgs exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchPlayers playerListWebData ->
            ( { model | players = playerListWebData }, Cmd.none )
