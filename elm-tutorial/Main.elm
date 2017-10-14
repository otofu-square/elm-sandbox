module App exposing (..)

import Html exposing (Html, button, div, program, text)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = Increment Int
    | Decrement Int



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Increment 10) ] [ text "+10" ]
        , div [] [ text (toString model) ]
        , button [ onClick (Decrement 10) ] [ text "-10" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment n ->
            ( model + n, Cmd.none )

        Decrement n ->
            ( model - n, Cmd.none )


subscriptions : model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
