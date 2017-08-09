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
            ret_val = self.find_internal(param, ret_val)
        end
        return ret_val
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