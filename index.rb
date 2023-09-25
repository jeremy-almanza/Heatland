def solution(s)
  photos = s.split("\n").map do |line|
    name, ext, city, datetime = line.match(/(.+)\.(jpg|png|jpeg),\s(.+),\s(.+)/).captures
    { name: name, ext: ext, city: city, datetime: datetime }
  end

  city_count = Hash.new(0)
  photos_grouped = photos.group_by { |photo| photo[:city] }

  photos_grouped.each do |city, city_photos|
    city_photos.sort_by! { |photo| photo[:datetime] }
    city_count[city] = city_photos.count.to_s.length
  end

  renamed_photos = photos.map do |photo|
    city = photo[:city]
    count = city_count[city]
    index = photos_grouped[city].index(photo) + 1
    "#{city}#{index.to_s.rjust(count, '0')}.#{photo[:ext]}"
  end

  renamed_photos.join(" ")
end


# Test the function
s = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"
puts solution(s)
