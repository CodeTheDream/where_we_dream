possible colors : "http://www.siwallpaperhd.com/light-color-yellow-wallpaper-sparknotes-7.html"

rails g scaffold user first_name last_name email password_digest user_type image:attachment
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


:state => :map
"Alabama AL 1" => nil
"Alaska AK 2" => "Alabama AL"
"Arizona AZ 3" => "Alaska AK"
"Arkansas AR 5" => nil
"California CA 6" => "Arizona AZ"
"Colorado CO 8" => "Arkansas AR"
"Connecticut CT 9" => "California CA"
"Delaware DE 10" => nil
"Florida FL 12" => "Connecticut CT"
"Georgia GA 13" => "Delaware DE"
"Hawaii HI 15" => nil
"Idaho ID 16" => "Florida FL"
"Illinois IL 17" => "Georgia GA"
"Indiana IN 18" => nil
"Iowa IA 19" => "Hawaii HI"
"Kansas KS 20" => "Idaho ID"
"Kentucky KY 21" => "Illinois IL"
"Lousiana LA 22" => "Indiana IN"
"Maine ME 23" => "Iowa IA"
"Maryland MD 24" => "Kansas KS"
"Massachusetts MA 25" => "Kentucky KY"
"Michigan MI 26" => "Lousiana LA"
"Minnesota MN 27" => "Maine ME"
"Mississippi MS 28" => "Maryland MD"
"Missouri MO 29" => "Massachusetts MA"
"Montana MT 30" => "Michigan MI"
"Nebraska NE 31" => "Minnesota MN"
"Nevada NV 32" => "Mississippi MS"
"New Hampshire NH 33" => "Missouri MO"
"New Jersey NJ 34" => "Montana MT"
"New Mexico 35" => "Nebraska NE"
"New York 36" => "Nevada NV"
"North Carolina 37" => "New Hampshire NH"
"North Dakota 38" => "New Jersey NJ"
"Ohio 39" => "New Mexico"
"Oklahoma 40" => "New York"
"Oregon 41" => "North Carolina"
"Pennsylvania 42" => "North Dakota"
"Rhode Island 44" => "Ohio"
"South Carolina 45" => "Oklahoma"
"South Dakota 46" => "Oregon"
"Tennessee 47" => "Pennsylvania"
"Texas 48" => nil
"Utah 49" => "Rhode Island"
"Vermont 50" => "South Carolina"
"Virginia 51" => "South Dakota"
"Washington 53" => "Tennessee"
"West Virginia 54" => "Texas"
"Wisconsin 55" => "Utah"
"Wyoming 56" => "Vermont"

{
  1: 2,
  2: 3,
  3: 6,
  5: 8,
  6: 9,
  8: 11, # Colorado maybe
  9: 12,
  10: 13,
  12: 16,
  13: 17,
  15: 19,
  16: 20,
  17: 21,
  18: 22,
  19: 23,
  20: 24,
  21: 25,
  22: 26,
  23: 27,
  24: 28,
  25: 29,
  26: 30,
  27: 31,
  28: 32,
  29: 33,
  30: 34,
  31: 35,
  32: 36,
  33: 37,
  34: 38,
  35: 39,
  36: 40,
  37: 41,
  38: 42,
  39: 44,
  40: 45,
  41: 46,
  42: 47,
  44: 49,
  45: 50,
  46: 51,
  47: 53,
  48: 54,
  49: 55,
  50: 56
}

{
  2: 1,
  3: 2,
  6: 3,
  8: 5,
  9: 6,
  11: 8, # Colorado maybe
  12: 9,
  13: 10,
  16: 12,
  17: 13,
  19: 15,
  20: 16,
  21: 17,
  22: 18,
  23: 19,
  24: 20,
  25: 21,
  26: 22,
  27: 23,
  28: 24,
  29: 25,
  30: 26,
  31: 27,
  32: 28,
  33: 29,
  34: 30,
  35: 31,
  36: 32,
  37: 33,
  38: 34,
  39: 35,
  40: 36,
  41: 37,
  42: 38,
  44: 39,
  45: 40,
  46: 41,
  47: 42,
  49: 44,
  50: 45,
  51: 46,
  53: 47,
  54: 48,
  55: 49,
  56: 50
}


names d.id 59

1
2
4
5
6
8
9
10
11
12
13
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
44
45
46
47
48
49
50
51
53
54
55
56
60
64
66
68
69
70
72
74
78


d.id 52

2
15
72
1
5
4
6
8
9
11
10
12
13
19
16
17
18
20
21
22
25
24
23
26
27
29
28
30
37
38
31
33
34
35
32
36
39
40
41
42
44
45
46
47
48
49
51
50
53
55
54
56
78
