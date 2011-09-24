#ActiveJSON

##Introduction

A lightweight JSON view renderer in the style of the usual Rails ActiveView engine.

Uses yajl to encode the JSON to text for extra speed.

##Installation

Installation is easy, just add `gem "activejson"` to your Gemfile and let bundle do the rest.  Alternatively `gem install activejson` will install the gem globally on your system.

##Example

Create a view, something like `user.activejson` and fill it with something like this:

    json.user do |user|
      user.name @user.name
      user.age @user.age
      user.pets(@user.pets) do |pet_json, pet|
        pet_json.name pet.name
        pet_json.age do |pet_age_json|
          pet_age_json.human_years pet.age*7
          pet_age_json.animal_years pet.age
        end
      end
    end

And, assuming your `@user` object has a name, an age and an array of pets, this will be rendered as:

    {
      user : {
               name : "Steve",
               age : 23,
               pets : [ 
                        { 
                          name : "frank",
                          age : { 
                                  human_years : 14,
                                  animal_years : 2 
                                }
                        },
                        {
                          name : "fred",
                          age : {
                                  human_years : 21,
                                  animal_years : 3
                                }
                        }
                      ]
              }
    }

...except not-pretty printed (for speed).

##Usage

###Introduction

In its simplest use case, ActiveJSON allows the view code to create JSON labels using (almost) any name, just by calling the label name as a method on an ActiveJSON object.

All data that you want to be added to your JSON should be added to the top-level `json` object, which is created for you by the ActiveJSON framework when the view code is run.

For example, to give a name and a date, use the following:

    json.name "Steve"
    json.date "12 Oct 2011"

This is sufficient for simple, flat JSON data blocks but will never create arrays or JSON objects within other objects.

###Sub-Objects

To mark a JSON label as being a JSON object, any function called on an ActiveJSON object can be called with a block, taking one parameter.  Within the block, the parameter can be used to add labels to the JSON sub-object.

For example:

    json.object do |obj|
      obj.name "Widget 1"
      obj.flavour "Lemon"
    end
    json.title "Objects"

Will render:

    { object : { name : "Widget 1", flavour : "Lemon" }, title : "Objects" }

###Arrays

To mark a JSON label as containing an array, pass any object that responds to `map` as an argument to the label's function and supply a block taking two parameters, the first of which will be the ActiveJSON object for the array element and the second of which will be the corresponding element from the argument.

For example, if `@users` contains Steve and Phil, then:

    json.users(@users) do |user_j, user|
      user_j.name user.name
    end

Will render to:

    { users : [ { name : "Steve" }, { name : "Phil" } ] }
