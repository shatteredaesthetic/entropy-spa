module Game.Message.Types exposing (..)


type alias Model =
    { message : Message }


type Message
    = Adding MsgTransition
    | Removing MsgTransition
    | Empty


type alias MsgTransition =
    { show : String
    , hide : String
    }


type Msg
    = Add
    | Remove
    | Print String
