#ActiveJSON

##Introduction

A lightweight JSON view renderer in the style of the usual Rails ActiveView engine.

Uses yajl to encode the JSON to text for extra speed.

##Installation

Installation is easy, just add `gem activejson` to your Gemfile and let bundle do the rest.  Alternatively `gem install activejson` will install the gem globally on your system.

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
                                  animal_years 2 
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
