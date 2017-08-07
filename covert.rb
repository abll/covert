# Class File To Handle MVP Implementation of covert.
require 'psych'
require 'pp'

class Covert

    attr_accessor :secret_ruby, :file_name

    # Constructor For Covert Class
    def initialize(yml_file)
        raise ArgumentError, 'Attempted To Process Null Object' if (yml_file.nil?)
        raise ArgumentError, 'Attempted To Process Non YAML File' unless ((File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml'))
        
        @file_name = yml_file
        @secret_ruby = Psych.parse_file(yml_file).to_ruby
    end

    # Dump The Yaml File
    def dump_tree
        puts "#{@file_name} - YAML Dump"
        puts @secret_ruby
    end

    # Pretty Print The YAML File
    def pretty_print_tree
        puts "#{@file_name} - Pretty Print The YAML Dump"
        pp @secret_ruby
    end

    #Method to Parse query List
    def process_query_list(query_list)
    end

    # Method To Find Nodes With Specific Values. - Using Psych
    def find(query)
    end

    #Test Method To return A Top Level Argument. 
    def find_1(query)
        puts "Key Test"
        puts @secret_ruby[query]
    end

    def get(path_array)
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