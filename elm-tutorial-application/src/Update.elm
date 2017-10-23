module Update exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import RemoteData
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchPlayers playerListWebData ->
            ( { model | players = playerListWebData }, Cmd.none )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( { model | route = newRoute }, Cmd.none )

        ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
            ( model, savePlayerCmd updatedPlayer )

        OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        OnPlayerSave (Err err) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
    { model | players = updatedPlayers }
