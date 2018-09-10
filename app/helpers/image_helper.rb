module ImageHelper
  def random_image(folder)
    image_path_prefix = "app/assets/images/"
    image_files = Dir.new("#{image_path_prefix}#{folder}")
                     .to_a.select { |f| f.downcase.match(/\.jpg|\.jpeg|\.png/) }
    image = image_files.sample
    "#{folder}/#{image}"
  end
end
