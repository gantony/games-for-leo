module Hello exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)



-- MODEL

type alias Size =
    { width: Int
    , height: Int
    }

type alias Position = 
    { x: Int
    , y: Int
    }

type alias Direction =
    Int

type alias Shark = 
    { position: Position
    }

type alias Octopus =
    { position: Position
    , direction: Direction
    }

type alias Canon =
    { direction: Direction
    , position: Position
    }

type alias Board =
    { size: Size
    , sharks: List Shark
    , octopuses: List Octopus
    , canon: Canon
    }

-- type alias Model = Board

-- MESSAGES


type Msg
    = Increment Int


boardSize: Size
boardSize = { width = 100, height = 100 }

canonPosition : Position
canonPosition = { x = 10, y = 10 }

emptyBoard : Board
emptyBoard = 
    { size = boardSize
    , sharks = []
    , octopuses = []
    , canon = 
        { direction = 25
        , position = canonPosition
        }
    }
    



init : ( Board, Cmd Msg )
init = ( emptyBoard, Cmd.none )



view : Board -> Html Msg
view model =
    div []
        [ button [ onClick (Increment 2) ] [ text "+" ]
        , text (toString model)
        ]



-- UPDATE


update : Msg -> Board -> ( Board, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Board -> Sub Msg
subscriptions model =
    Sub.none


-- MAIN


main : Program Never Board Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

