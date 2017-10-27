module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Events exposing (..)
import Http exposing (post)
import Json.Decode as Decode
import Post


---- MODEL ----


type alias Model =
    { post : Post
    , form : String
    }


initialPost : Post.Model
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
    = PostMsg PostMsg
    | Input String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Post.Msg msg ->
            Post.update msg model

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
        [ postView model.post
        , input
            [ type_ "text", onInput Input ]
            []
        , p
            []
            [ text <| "form: " ++ model.form ]
        , button
            [ onClick GetPost ]
            [ text "Get Post" ]
        ]


postView : Post -> Html Msg
postView post =
    div []
        [ p
            []
            [ text <| "userId: " ++ toString post.userId ]
        , p
            []
            [ text <| "id: " ++ toString post.id ]
        , p
            []
            [ text <| "title: " ++ post.title ]
        , p
            []
            [ text <| "body: " ++ post.body ]
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
