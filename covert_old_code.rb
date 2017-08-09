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
    def process_query_string(query_string)
        query_list = query_string.split('/')
        raise ArgumentError, 'Query String In Wrong Format' if (query_string.nil?)
        return query_list.reverse
    end

    # Method To Find Nodes With Specific Values. - Using Psych
    def find(query)
        query_list = self.process_query_string(query)
        ret = self.find_nested(query_list)
        if ret.nil?
            return "Parameter Not Found At Path - #{query}"
        end
        return ret
    end

    #Test Method To return A Top Level Argument. 
    def find_internal(param, array)
        #puts "Got Here With Param - #{param}"
        #puts array[param]
        return nil unless (array.respond_to?('each'))
        
        if(array[param].nil?)
            return nil
        else
            return array[param]
        end
    end

    def find_nested(query_array)
        ret_val = @secret_ruby
        loop do
            param = query_array.pop
            break if((ret_val.nil?) || (param.nil?))
            puts param
            ret_val = self.find_internal(param, ret_val)
            pp ret_val
        end
        return ret_val
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


=begin
    
def find(query)
        ret_val = false
        query_list = self.process_query_string(query)
        query_list.each do |param|
            ret_val = self.find_internal(param, ret_val)
            if(!ret_val)
                return "No Value Available At Requested Path - #{query}"
            end
        end
        return ret_val
    end

    def find_recursive(query_array)
        temp_arr = @secret_ruby
        loop do
            param = query_array.pop
            puts param
            ret_val = self.find_internal(param, ret_val)
            puts ret_val
            break if(param.nil?)
        end
    end

        def find_alt(param, array)
        if(array[param].responds_to?('each'))
            return self.find_alt(param, array[param])
        elsif(array[param].responds_to?('to_s'))
            return array[param]
        else
            return nil
        end 
    end

    def find_recursive(query_array)
        ret_val = @secret_ruby
        loop do
            param = query_array.pop
            break if((ret_val.nil?) || (param.nil?))
            puts param
            ret_val = self.find_internal(param, ret_val)
            pp ret_val
        end
        return ret_val
    end

    #Test Method To return A Top Level Argument. 
    def find_internal(param, array)
        #puts "Got Here With Param - #{param}"
        #puts array[param]
        return nil unless (array.respond_to?('each'))
        
        if(array[param].nil?)
            return nil
        else
            return array[param]
        end
    end

=end
    
=end