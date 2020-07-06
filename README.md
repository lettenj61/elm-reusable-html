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
   Reusable.wrap ( li [] ) a

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


## Version changes

Basically there are no big feature changes between `1.0.0` and `2.0.0`, but `2.0.0` has more clearer APIs. 

Please consider that `2.0.0` was the initial release and ignore `1.0.0`.


## License

This library is licensed under either of:

- Apache 2.0
- MIT