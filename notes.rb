possible colors :
  "http://www.siwallpaperhd.com/light-color-yellow-wallpaper-sparknotes-7.html"

rails g scaffold user first_name last_name email password_digest user_type
rails g controller sessions new create destroy

rails g scaffold like user:references likable:references{polymorphic} value:boolean

god > administrator > moderator&recruiter > viewer

rails generate
  migration
    migration

  model
    model
    migration

  controller
    controller
    routes
    views

  resource
    model
      test
    migration
    controller
      test
      fixtures
    routes
    helper
    assets
      scss
      coffee

  scaffold
    model
    migration
    controller
    routes
    views

can do anything = god
can delete comments = moderator|god|admin
can delete questions = god
can delete schools = god
can delete(disable?) users = god|admin(scope:viewers)
can create comments = anyone
can create questions = god|admin
can create schools = god|admin
can create recruiter = admin|god
can create moderator = admin|god
can create admin = god
can create god = god
can edit questions = admin|god
can edit schools = recruiter|admin|god
can edit users = nobody

viewers can create comments
moderators can delete comments && recruiters can create/edit schools
admin can create questions|schools|recruiters|moderators, delete viewers
god can create admin|god, delete schools|questions|everyone
