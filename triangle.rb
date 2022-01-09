=begin
  This is a example for ruby2d. ref -> https://www.ruby2d.com/learn/get-started/
=end


require 'ruby2d'

set title: "Hello Triangle"

Triangle.new(
  x1: 320, y1: 50,
  x2: 540, y2: 430,
  x3: 100, y3: 430,
  color: [ 'red', 'green', 'blue' ]
)

show
