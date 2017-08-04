require 'yaml'

node = YAML::parse( <<EOY )
one: 1
two: 2
EOY

puts node.inspect