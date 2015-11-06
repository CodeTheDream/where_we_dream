class String
  def clean # this method gets rid of any characters in a string that usually need some special hexadecimal encoding for URLs
    # self.gsub(/&|\s|:|\/|\$|\W/,"") # really, we only need to delete '$'s and '/' but whatever
    self.gsub(/&|\s|:|\/|\$/,"") # really, we only need to delete '$'s and '/' but whatever
  end

  def abbreviate
    self.gsub(/ minut(es|e)/, "m")
    .gsub(/ hou(rs|r)/, "h")
    .gsub(/ da(ys|y)/, "d")
    .gsub(/ mont(hs|h)/, "mo")
    .gsub(/ yea(rs|r)/, "y")
    .gsub(/(about|almost) /, "~")
    .gsub(/less than a/, "<1")
    .gsub(/over /, ">")
  end
end
