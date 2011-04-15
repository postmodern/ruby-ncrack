require 'rprogram/task'

module Ncrack
  class Task < RProgram::Task

    # Target Specification
    short_option :flag => '-iX', :name => :input_xml
    short_option :flag => '-iN', :name => :input_normal
    short_option :flag => '-iL', :name => :input_list
    long_option :flag => '--exclude', :separator => ','
    long_option :flag => '--excludefile', :name => :exclude_file

    # Service Specification
    short_option :flag => '-p', :name => :ports, :separator => ','
    short_option :flag => '-m', :name => :service_options, :separator => ','
    short_option :flag => '-g', :name => :global_options, :separator => ','

    # Timing and Performance 
    short_option :flag => '-T', :name => :timing
    long_option :flag => '--connection-limit'

    # Authentication
    short_option :flag => '-U'
    short_option :flag => '-P'
    long_option :flag => '--user'
    long_option :flag => '--pass'
    long_option :flag => '--passwords-first'

    # Output
    short_option :flag => '-oN', :name => :output_normal
    short_option :flag => '-oX', :name => :output_xml
    short_option :flag => '-oA', :name => :output_all
    short_option :flag => '-v', :name => :verbose
    short_option :flag => '-d', :name => :debug
    long_option :flag => '--nsock-trace'
    long_option :flag => '--log-errors'
    long_option :flag => '--append-output'

    # Misc
    long_option :flag => '--resume'
    short_option :flag => '-f', :name => :first
    short_option :flag => '-6', :name => :ipv4
    short_option :flag => '-sL', :name => :list
    long_option :flag => '--datadir'
    short_option :flag => '-V', :name => :version
    short_option :flag => '-h', :name => :help

    non_option :trailing => true, :name => :targets

  end
end
