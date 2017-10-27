module Post exposing (..)

import Http
import Json.Decode as Decode


type alias Model =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


type Msg
    = GetPost String
    | LoadPost (Result Http.Error Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPost id ->
            ( model, sendRequest id )

        LoadPost (Ok post) ->
            ( post, Cmd.none )

        LoadPost (Err _) ->
            ( model, Cmd.none )


getPost : String -> Http.Request Model
getPost id =
    let
        url =
            "https://jsonplaceholder.typicode.com/posts/" ++ id
    in
    Http.get url decodePost


decodePost : Decode.Decoder Model
decodePost =
    Decode.map4 Model
        (Decode.field "userId" Decode.int)
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "body" Decode.string)


sendRequest : String -> Cmd Msg
sendRequest id =
    Http.send LoadPost (getPost id)
