module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }



---- MODEL ----


type alias Model =
    { quote : String }


init : ( Model, Cmd Msg )
init =
    ( { quote = "" }, Cmd.none )



---- UPDATE ----


type Msg
    = GetQuote


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetQuote ->
            ( { model | quote = model.quote ++ "A quote! " }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h2
            [ class "text-center" ]
            [ text "Chuck Norris Quotes" ]
        , p
            [ class "text-center" ]
            [ button
                [ class "btn btn-success", onClick GetQuote ]
                [ text "Grab a quote!" ]
            ]
        , blockquote
            []
            [ p
                []
                [ text model.quote ]
            ]
        ]
