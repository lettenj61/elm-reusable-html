module Spec exposing (suite)

import Expect
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector

import Reusable exposing (CustomTag, Tag)
import Reusable.Example as Example
import Html
import Html.Attributes as Attributes


suite : Test
suite =
    describe "Reusable module"
        [ describe "CustomTag type" customTagTests
        , describe "Utility functions" utilityTests
        ]


customTagTests : List Test
customTagTests =
    [ test "custom tag type satisfies compiler" <|
        \_ ->
            let
                myHeader : CustomTag { head : String } msg
                myHeader _ { head } =
                    Html.header
                        []
                        [ Html.div [ Attributes.id "test" ]
                            [ Html.text head ]
                        ]
            in
            myHeader [] { head = "Boom" }
                |> Query.fromHtml
                |> Query.find [ Selector.tag "div" ]
                |> Query.contains [ Html.text "Boom" ]
    ]


utilityTests : List Test
utilityTests =
    [ test "extend" <|
        \_ ->
            Html.div []
                [ Example.container
                    [ Attributes.id "container" ]
                    [ Html.text "content" ]
                ]
            |> Query.fromHtml
            |> Query.find [ Selector.id "container" ]
            |> Query.has
                [ Selector.tag "section"
                , Selector.classes [ "section", "container" ]
                ]

    , test "deeply wrapped" <|
        \_ ->
            Html.main_ []
                [ Example.deepNode []
                    [ Html.text "bottom" ]
                ]
            |> Query.fromHtml
            |> Query.findAll [ Selector.tag "div" ]
            |> Query.count (Expect.equal 3)

    , test "wrapped element ordering" <|
        \_ ->
            Html.main_ []
                [ Example.deepNode []
                    [ Html.text "bottom" ]
                ]
            |> Query.fromHtml
            |> Query.findAll [ Selector.tag "div" ]
            |> Query.index 0
            |> Query.has [ Selector.class "top" ]
    ]