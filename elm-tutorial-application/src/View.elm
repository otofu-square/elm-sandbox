module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (..)
import Msgs exposing (..)
import Players.Edit
import Players.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Players.List.view model.players

        PlayerRoute playerId ->
            playerEditPage model playerId

        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
            case maybePlayer of
                Just player ->
                    Players.Edit.view player

                Nothing ->
                    notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]
