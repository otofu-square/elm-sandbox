module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Http exposing (post)
import Json.Decode as Decode


---- MODEL ----


type alias Model =
    { post : Post }


type alias Post =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


initialPost : Post
initialPost =
    { userId = 0
    , id = 0
    , title = "null"
    , body = "null"
    }


init : ( Model, Cmd Msg )
init =
    ( { post = initialPost }, Cmd.none )



---- UPDATE ----


type Msg
    = GetPost
    | LoadPost (Result Http.Error Post)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPost ->
            ( model, sendRequest 1 )

        LoadPost (Ok post) ->
            ( { post = post }, Cmd.none )

        LoadPost (Err _) ->
            ( model, Cmd.none )


getPost : Int -> Http.Request Post
getPost id =
    let
        url =
            "https://jsonplaceholder.typicode.com/posts/" ++ toString id
    in
    Http.get url decodePost


decodePost : Decode.Decoder Post
decodePost =
    Decode.map4 Post
        (Decode.field "userId" Decode.int)
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "body" Decode.string)


sendRequest : Int -> Cmd Msg
sendRequest id =
    Http.send LoadPost (getPost id)



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        []
        [ p
            []
            [ text <| "userId: " ++ toString model.post.userId ]
        , p
            []
            [ text <| "id: " ++ toString model.post.id ]
        , p
            []
            [ text <| "title: " ++ model.post.title ]
        , p
            []
            [ text <| "body: " ++ model.post.body ]
        , button
            [ onClick GetPost ]
            [ text "Get Post" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
