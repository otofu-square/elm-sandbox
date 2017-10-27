module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Events exposing (..)
import Http exposing (post)
import Json.Decode as Decode


---- MODEL ----


type alias Model =
    { post : Post
    , form : String
    }


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
    ( { post = initialPost, form = "" }, Cmd.none )



---- UPDATE ----


type Msg
    = GetPost
    | LoadPost (Result Http.Error Post)
    | Input String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPost ->
            ( model, sendRequest model.form )

        LoadPost (Ok post) ->
            ( { model | post = post }, Cmd.none )

        LoadPost (Err _) ->
            ( model, Cmd.none )

        Input string ->
            ( { model | form = string }, Cmd.none )


getPost : String -> Http.Request Post
getPost id =
    let
        url =
            "https://jsonplaceholder.typicode.com/posts/" ++ id
    in
    Http.get url decodePost


decodePost : Decode.Decoder Post
decodePost =
    Decode.map4 Post
        (Decode.field "userId" Decode.int)
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "body" Decode.string)


sendRequest : String -> Cmd Msg
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
        , p
            []
            [ text <| "form: " ++ model.form ]
        , input
            [ type_ "text", onInput Input ]
            []
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
