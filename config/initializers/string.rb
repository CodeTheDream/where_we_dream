class String
  def clean # this method gets rid of any characters in a string that usually need some special hexadecimal encoding for URLs
    # self.gsub(/&|\s|:|\/|\$|\W/,"") # really, we only need to delete '$'s and '/' but whatever
    self.gsub(/&|\s|:|\/|\$/,"") # really, we only need to delete '$'s and '/' but whatever
  end
end
