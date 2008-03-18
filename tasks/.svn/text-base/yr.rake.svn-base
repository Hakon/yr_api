desc "Hent stedsliste fra YR"
task :fetch_places do
  data = nil
  File.open("config/places.txt","w") do |f|
    data = open("http://www12.nrk.no/yr.no/viktigestader.txt").read
    f.write(data)
  end
  places = []
  data.each_line do |line|
    parts = line.split("\t")
    p = Yr::Place.new(:fylke => parts[4], :kommune => parts[3], :sted => parts[1])
    places << p
  end
  File.open("config/places.yml","w"){|f| f.write(YAML::dump(places))}
end


desc "Update the website"
task :update_web => :docs do
  system("cp -R doc irbno/yr/")
  system("rsync -av --delete irbno zmalltalker@rubyforge.org:/var/www/gforge-projects")
end