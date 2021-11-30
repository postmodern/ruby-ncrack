require 'command_mapper/command'

module Ncrack
  #
  # ## Example
  #
  #     require 'ncrack'
  #     
  #     Ncrack::Command.run(targets: %w[10.0.0.130:21 192.168.1.2:22], output_xml: 'ncrack.xml')
  #
  # ## `ncrack` options:
  #
  # * `-iX` - `ncrack.input_xml`
  # * `-iN` - `ncrack.input_normal`
  # * `-iL` - `ncrack.input_list`
  # * `--exclude` - `ncrack.exclude`
  # * `--excludefile` - `ncrack.exclude_file`
  # * `-p` - `ncrack.ports`
  # * `-m` - `ncrack.service_options`
  # * `-g` - `ncrack.global_options`
  # * `-T` - `ncrack.timing`
  # * `--connection-limit` - `ncrack.connection_limit`
  # * `--stealth-linear` - `ncrack.stealth_linear`
  # * `-U` - `ncrack.username_file`
  # * `-P` - `ncrack.password_file`
  # * `--user` - `ncrack.user`
  # * `--pass` - `ncrack.pass`
  # * `--passwords-first` - `ncrack.passwords_first`
  # * `--pairwise` - `ncrack.pairwise`
  # * `-oN` - `ncrack.output_normal`
  # * `-oX` - `ncrack.output_xml`
  # * `-oA` - `ncrack.output_all`
  # * `-v` - `ncrack.verbose`
  # * `-d` - `ncrack.debug`
  # * `--nsock-trace` - `ncrack.nsock_trace`
  # * `--log-errors` - `ncrack.log_errors`
  # * `--append-output` - `ncrack.append_output`
  # * `--resume` - `ncrack.resume`
  # * `--save` - `ncrack.save`
  # * `-f` - `ncrack.first`
  # * `-6` - `ncrack.ipv4`
  # * `-sL` - `ncrack.list`
  # * `--datadir` - `ncrack.datadir`
  # * `-V` - `ncrack.version`
  # * `-h` - `ncrack.help`
  #
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
