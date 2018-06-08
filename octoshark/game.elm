module Hello exposing (..)

-- import AnimationFrame
import Collage exposing (..)
import Transform exposing (..)
import Color exposing (..)
import Element exposing (..)
import Html exposing (..)
import Time exposing (Time)

-- MAIN


main : Program Never Board Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Size =
    { width : Int
    , height : Int
    }


type alias Position =
    { x : Float
    , y : Float
    }


type alias Direction =
    Float


type alias Shark =
    { position : Position
    }


type alias Octopus =
    { position : Position
    , direction : Direction
    }


type alias Canon =
    { direction : Direction
    , position : Position
    }


type alias Board =
    { size : Size
    , sharks : List Shark
    , octopuses : List Octopus
    , canon : Canon
    }



-- type alias Model = Board
-- MESSAGES


type Msg
    = Increment Int


boardSize : Size
boardSize =
    { width = 100, height = 100 }


canonPosition : Position
canonPosition =
    { x = 50, y = 50 }


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



-- UPDATE


update : Msg -> Board -> ( Board, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS

-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     AnimationFrame.times Tick


subscriptions : Board -> Sub Msg
subscriptions model =
    Sub.none


init : ( Board, Cmd Msg )
init =
    ( emptyBoard, Cmd.none )


-- view : Board -> Html Msg
-- view model =
--     div []
--         [ button [ onClick (Increment 2) ] [ text "+" ]
--         , text (toString model)
--         ]


view : Board -> Html Msg
view board =
    toHtml (collage 300 300 [canon board.canon, bullet { x=10, y=10} 45]) --(canon board.canon)




offsetP : Position -> Float -> Float -> Float -> Position
offsetP p w h a = 

  let
    m = rotation (degrees a)
  in
  
    { x = p.x --- w/2
    , y = p.y --- h/2
    }


-- canon: Canon -> Form
-- canon c = Collage.text "This is the canon" 
-- -- heartBeat : Float -> Element
-- -- heartBeat delta =
--     -- collage 300 300 [ heart |> scale (abs (sin (delta / 1000))) ]

canon : Canon -> Form
canon c =

  let
    w = 30
    h = 6
    p = offsetP c.position  w h c.direction
  in

    group
    [ Collage.rect w h |> filled red |> move (p.x, p.y) |> rotate (degrees c.direction)
    , Collage.circle 8 |> filled red |> move (c.position.x - 15, c.position.y)
    ]

bullet : Position -> Float -> Form
bullet p angle =
    group
    [ Collage.rect 10 2 |> filled purple |> move (p.x, p.y) |> rotate (degrees angle)
    ]

heart : Form
heart =
    
    group
        [ ngon 4 50 |> filled red |> move ( 0, 0 )
        , circle 36 |> filled red |> move ( 20, 20 )
        , circle 36 |> filled red |> move ( -20, 20 )
        ]

