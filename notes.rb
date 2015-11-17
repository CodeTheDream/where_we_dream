possible colors : "http://www.siwallpaperhd.com/light-color-yellow-wallpaper-sparknotes-7.html"

rails g scaffold user first_name last_name email password_digest user_type
rails g controller sessions new create destroy
rails g scaffold like user:references opinionable:references{polymorphic} value:boolean
rails g scaffold scholarship name description:text deadline:datetime amount:integer requirements:text full_ride:boolean
rails g scaffold story title description:text body:text user:references anonymous:boolean
rails g scaffold state name abbreviation in_state:boolean description:text

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
      test
    migration
    controller
      test
    routes
    views
end

god > administrator > moderator&recruiter > viewer

user_types = %w[God Admin Moderator Recruiter Student Parent Teacher Supporter]

can do anything = god
can delete comments = moderator|god|admin
can delete questions = god
can delete schools = god
can delete(disable?) users = god|admin(scope:viewers)
can create comments = anyone
can create questions = god|admin
can create schools = recruiter|admin|god
can create recruiter = admin|god
can create moderator = admin|god
can create admin = god
can create god = god|rails c
can edit questions = admin|god
can edit schools = recruiter|admin|god
can edit users = nobody

viewers can create comments
moderators can delete comments && recruiters can create/edit schools
admin can create questions|schools|recruiters|moderators, ban viewers
god can create admin|god, delete schools|questions|scholarships, ban everyone

URL_encoding {
  "&" => "&amp;",
  " " => "%20",
  ":" => "%3A",
  "/" => "%2F",
  "$" => "%24"
}

"$2a$10$UjGEap51qv67nw02o45HK.DNm3rzyTSAvviqkw9lFKo6lFeHDXxb2" # original
" $ 2a $ 10 $ UjGEap51qv67nw02o45HK.DNm3rzyTSAvviqkw9lFKo6lFeHDXxb2"
"%242a%2410%24UjGEap51qv67nw02o45HK.DNm3rzyTSAvviqkw9lFKo6lFeHDXxb2" # parser output

"$2a$10$Zhm7FnuCBppHZvmkN9J5teESnkEh5DhlniVV7NGwt0U2YAhhq9rKC" # original
" $ 2a $ 10 $ Zhm7FnuCBppHZvmkN9J5teESnkEh5DhlniVV7NGwt0U2YAhhq9rKC"
"%242a%2410%24Zhm7FnuCBppHZvmkN9J5teESnkEh5DhlniVV7NGwt0U2YAhhq9rKC" # parser output

"$2a$10$3xWNCdf65c1W2UpUAGXFQ.FZx8hTfUTiB.HDbwA4CpxxLiv1VRvk." # original
" $ 2a $ 10 $ 3xWNCdf65c1W2UpUAGXFQ.FZx8hTfUTiB.HDbwA4CpxxLiv1VRvk."
"%242a%2410%243xWNCdf65c1W2UpUAGXFQ.FZx8hTfUTiB.HDbwA4CpxxLiv1VRvk." # parser output

"$2a$10$8BW7fbTpB8HtaGBrxR/i4OtuV/SSR4H2iwFH1XmdyQqscE1LjB4QG" # original
" $ 2a $ 10 $ 8BW7fbTpB8HtaGBrxR / i4OtuV / SSR4H2iwFH1XmdyQqscE1LjB4QG"
"%242a%2410%248BW7fbTpB8HtaGBrxR%2Fi4OtuV%2FSSR4H2iwFH1XmdyQqscE1LjB4QG" # parser output

"$2a$10$Cr1W3TAdouGMnkCZLUsUMO/u2ecwI7T.HQ.C/PWPqmZn6Kz1PgMu2" # original
" $ 2a $ 10 $ Cr1W3TAdouGMnkCZLUsUMO / u2ecwI7T.HQ.C / PWPqmZn6Kz1PgMu2"
"%242a%2410%24Cr1W3TAdouGMnkCZLUsUMO%2Fu2ecwI7T.HQ.C%2FPWPqmZn6Kz1PgMu2" # parser output


◉◍◎◌○◔◑◕●
