module Reusable.Example exposing (..)

import Html
import Html.Attributes exposing (class)
import Reusable exposing (Tag)


container : Tag msg
container =
    Html.section
        |> Reusable.extend
            [ class "section"
            , class "container"
            ]


wrappedParagraph : Tag msg
wrappedParagraph =
    Html.p
        |> Reusable.wrap
            (Html.article [ class "inner" ])


deepNode : Tag msg
deepNode =
    Html.span
        |> Reusable.wrapDeep
            [ Html.div [class "top"]
            , Html.div [class "intermediate"]
            , Html.div [class "one-more"]
            ]