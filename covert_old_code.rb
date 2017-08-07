# Class File To Handle MVP Implementation of covert.
require 'psych'
require 'yaml'
require 'pp'

class Covert
    SCALAR = 'Psych::Nodes::Scalar'
    MAP = 'Psych::Nodes::Mapping'
    DOC = 'Psych::Nodes::Document'
    STREAM = 'Psych::Nodes::Stream'

    attr_accessor :secret_tree, :secret_ruby

    # Constructor For Covert Class
    def initialize(yml_file)
        raise ArgumentError, 'Attempted To Process Null Object' if (yml_file.nil?)
        raise ArgumentError, 'Attempted To Process Non YAML File' unless ((File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml'))
        
        @secret_tree = Psych.parse_file(yml_file)
        @secret_ruby =  @secret_tree.to_ruby
    end

    # Dump The tree For Debugging Process. - Using Psych
    def dump_tree
        puts "YAML Tree Dump -  Using Psych"
        p @secret_tree.each
        puts "YAML Node ID"
        puts @secret_tree
    end

    # Pretty Print The Tree For Debugging Process. - Using Psych
    def pretty_print_tree
        puts "Pretty Print Values In The YAML Tree - Using Psych"
        @secret_tree.each do |node|
            puts node
        end
    end

    # Print The Values In The Tree For Debugging Process. - Using Psych
    def print_value_tree
        level = 1
        puts "Printing Values In The YAML Tree"
        @secret_tree.each do |node|
            next if (node.children.nil?)
            puts level
            node.children.each do |child|
                if(child.class.to_s.eql?(SCALAR))
                    puts child.value
                end
            end
            level += 1
        end
    end

    # Method To Find Nodes With Specific Values. - Using Psych
    def find(query)
        @secret_tree.each do |node|
            next if (node.children.nil?)
            node.children.each do |child|
                if(child.class.to_s.eql?(SCALAR))
                    next unless self.compare(query, child)
                    puts "Eureka I Found You - #{child.value}"
                end
            end
        end
    end

    def find_1(query)
        puts 'Arrays'
        pp @secret_ruby
        
        puts "Does This Have The Keys"
        puts @secret_ruby.has_key?(query)

        puts "Key Test"
        puts @secret_ruby[query]
    end
    
    # Method To Find Values In Yaml
    def compare(query, params)
        return (query.to_s == params.value.to_s)
    end

    def self.push(params, values)
    end

    def self.encrypt()
    end

    def self.decrypt()
    end

    def self.key()
    end
end


=begin
    
puts 'Keys'
pp @secret_ruby.keys

puts "Flattened Array"
pp @secret_ruby.flatten
    
=end