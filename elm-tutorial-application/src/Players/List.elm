module Players.List exposing (..)

import Commands
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (maybe)
import Json.Decode.Pipeline exposing (resolve)
import Models exposing (Player)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)


view : WebData (List Player) -> Html Msg
view players =
    div []
        [ nav
        , maybeList players
        ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success player ->
            list player

        RemoteData.Failure error ->
            text (toString error)


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td [] [ editBtn player ]
        ]


editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
    a [ class "btn regular", href path ]
        [ i [ class "fa fa-pencil mr1" ] []
        , text "Edit"
        ]
