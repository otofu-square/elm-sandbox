module Post exposing (..)

import Http


type alias Model =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


type Msg
    = GetPost
    | LoadPost (Result Http.Error Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPost ->
            ( model, sendRequest model.form )

        LoadPost (Ok post) ->
            ( { model | post = post }, Cmd.none )

        LoadPost (Err _) ->
            ( model, Cmd.none )
