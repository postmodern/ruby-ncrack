require 'command_mapper/command'

module Ncrack
  class Command < CommandMapper::Command

    command 'ncrack' do
      # Target Specification
      option '-iX', name: :input_xml, value: {type: InputFile.new}
      option '-iN', name: :input_normal, value: {type: InputFile.new}
      option '-iL', name: :input_list, value: {type: InputFile.new}
      option '--exclude', value: {type: List.new}
      option '--excludefile', name: :exclude_file, value: {type: InputFile.new}

      # Service Specification
      option '-p', name: :ports, value: {type: List.new}
      option '-m', name: :service_options, value: {type: List.new}
      option '-g', name: :global_options, value: {type: List.new}

      # Timing and Performance 
      option '-T', name: :timing, value: {type: Num.new}
      option '--connection-limit', value: {type: Num.new}
      option '--stealth-linear'

      # Authentication
      option '-U', name: :username_file, value: {type: InputFile.new}
      option '-P', name: :password_file, value: {type: InputFile.new}
      option '--user', value: {type: List.new}
      option '--pass', value: {type: List.new}
      option '--passwords-first'
      option '--pairwise'

      # Output
      option '-oN', name: :output_normal, value: true
      option '-oX', name: :output_xml, value: true
      option '-oA', name: :output_all, value: true
      option '-v', name: :verbose
      option '-d', name: :debug
      option '--nsock-trace', value: {type: Num.new}
      option '--log-errors'
      option '--append-output'

      # Misc
      option '--resume', value: {type: InputFile.new}
      option '--save', value: true
      option '-f', name: :first
      option '-6', name: :ipv4
      option '-sL', name: :list
      option '--datadir', value: {type: InputDir.new}
      option '-V', name: :version
      option '-h', name: :help

      argument :targets, repeats: true

    end

    alias usernames user
    alias usernames= user=

    alias passwords pass
    alias passwords= pass=

  end
end
