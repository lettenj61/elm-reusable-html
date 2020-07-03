module Reusable exposing
    ( CustomTag
    , Tag
    , extend
    , wrap, wrapDeep
    )

{-| Minimal reusable functions to enrich common use of elm/html.

# Types
@docs CustomTag, Tag

# Utilities
@docs extend, wrap, wrapDeep

-}


import Html exposing (Attribute, Html)


-- TAGS


{-| A type of function which constructs `Html` node with given `msg` and `children`.

This is merely an synonym for those values reside in `elm/html`,
which you must be already familiar with.

You can use this to make a little statement about
what type does your custom function would accept as child node.

    type alias CardProp msg =
        { title : String
        , body : Html msg
        }

    card : CustomTag (CardProp msg) msg
    card attributes { title, body } =
        div
            (class "card" :: attributes)
            [ span [ text title ]
            , body
            ]
-}
type alias CustomTag children msg =
    List (Attribute msg) -> children -> Html msg


{-| The fundamental function type that constructs `Html` from `List` of `Attribute`s and `Html`s.

Frankly, this package is all about defining your own `Tag` types, with as fewer keystrokes as possible.

    import Html exposing (..)

    myTag : Tag msg
    myTag =
        div
-}
type alias Tag msg =
    CustomTag (List (Html msg)) msg



-- HTML STRUCTURES


{-| Extend given `Tag` function to ensure it would always have default `Attribute`s.

    row : Tag msg
    row =
        extend [class "row"] div

    row [] [ text "hello" ]
        == """<div class="row">hello</div>"""
-}
extend : List (Attribute msg) -> Tag msg -> Tag msg
extend defaults tag =
    \attributes children ->
        tag
            (attributes ++ defaults)
            children


{-| Wraps another node so that it would be rendered inside the `wrapper` node.

    wrapper : Tag msg
    wrapper =
        span
            |> wrap ( div, [ class "wrapper" ] )

    wrapper [] [ text "in depth" ]
        ==  """
            <div class="wrapper">
                <span>in depth</span>
            </div>
            """
-}
wrap : ( Tag msg, List (Attribute msg) ) -> Tag msg -> Tag msg
wrap  (wrapper, wrapperAttrs ) tag =
    \attributes children ->
        wrapper wrapperAttrs
            [tag attributes children]


{-| `wrapDeep` plants resulting view of given `tag` into deeply nested structure.

The first element in given `outerNodes` list would come topmost.

    postItem : Tag msg
    postItem =
        p
            |> extend [ class "post-item" ]
            |> wrapDeep
                [ ( div, [ class "post-wrapper" ] )
                , ( article, [ class "post-body" ] )
                ]

    postItem [] [ text "New blog!" ]
        ==  """
            <div class="post-wrapper">
                <article class="post-body">
                    <p class="post-item">New blog!</p>
                </article>
            </div>
            """
-}
wrapDeep : List ( Tag msg, List (Attribute msg) ) -> Tag msg -> Tag msg
wrapDeep outerNodes tag =
    wrapDeepHelp (List.reverse outerNodes) tag


wrapDeepHelp : List ( Tag msg, List (Attribute msg) ) -> Tag msg -> Tag msg
wrapDeepHelp outerNodes tag =
    case outerNodes of
        [] ->
            tag

        pair :: rest ->
            wrapDeepHelp rest <| wrap pair tag
