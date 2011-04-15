require 'ncrack/task'

require 'rprogram/program'

module Ncrack
  class Program < RProgram::Program

    name_program 'ncrack'

    #
    # Finds the `ncrack` program and starts cracking.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for ncrack.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for ncrack.
    #
    # @yieldparam [Task] task
    #   The ncrack task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see #crack
    #
    def self.crack(options={},exec_options={},&block)
      find.crack(options,exec_options,&block)
    end

    #
    # Starts cracking.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for ncrack.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for ncrack.
    #
    # @yieldparam [Task] task
    #   The ncrack task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see http://rubydoc.info/gems/rprogram/0.3.0/RProgram/Program#run-instance_method
    #   For additional exec-options.
    #
    def crack(options={},exec_options={},&block)
      run_task(Task.new(options,&block),exec_options)
    end

  end
end
