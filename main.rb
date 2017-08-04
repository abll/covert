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
    when '-pvt'
        covert_reader.print_value_tree
    when '-f'
        if(ARGV[1].nil?)
            puts "No Search Query Entered"
        else
            puts covert_reader.find_1(ARGV[1].to_s)
        end
    else
        puts "Incorrect Parameters Passed"
    end
end




