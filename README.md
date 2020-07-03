elm-reusable-html
====

Minimal reusable functions to enrich common use of elm/html

## Installation

```sh
elm install lettenj61/elm-reusable-html
```

## Example

This package come with two part:

1. `Tag msg` type, an alias for `List (Attribute msg) -> List (Html msg) -> Html msg`.
2. Small collection of function to deal with `Tag`s.

Explore the document and tests for use cases.

```elm
import Html exposing (..)
import Html.Attributes exposing (..)
import Reusable exposing (Tag)

-- You'll have an `a` anchor wrapped in `li`
bcAnchor : Tag msg
bcAnchor =
   Reusable.wrap ( li, [] ) a

-- This `ul` always have default `class`
bcList : Tag msg
bcList =
  ul |> Reusable.extend [ class "breadcrumb" ]

-- And put things together
breadcrumb : List ( String, String ) -> Html msg
breadcrumb props =
  bcList [] <|
    List.map
      (\( path, lbl ) ->
        bcAnchor [ href path ] [ text lbl ]
      )
      props
```

## License

This library is licensed under either of:

- MIT
- Apache 2.0