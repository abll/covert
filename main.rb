# The Initial Main File for Covert Ruby Gem 
require 'psych'
require_relative 'covert'

# Initialization of Test Variables

fake_file = nil

covert_reader = Covert.new('covert.yml')

# --------- Script -----------

if ARGV.empty?
    puts "No Covert Parameters Passed"
else
    case ARGV[0].to_s
    when '-d'
        covert_reader.dump_tree
    when '-ppt'
        covert_reader.pretty_print_tree
    when '-pqs'
        if(ARGV[1].nil?)
            puts "No Query String Entered"
        else
            covert_reader.process_query_string(ARGV[1].to_s)
        end
    when '-f'
        puts covert_reader.find(ARGV[1].to_s)
    else
        puts "Incorrect Parameters Passed"
    end
end




