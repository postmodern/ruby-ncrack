# ruby-ncrack

[![CI](https://github.com/postmodern/ruby-ncrack/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/ruby-ncrack/actions/workflows/ruby.yml)
[![Gem Version](https://badge.fury.io/rb/ruby-ncrack.svg)](https://badge.fury.io/rb/ruby-ncrack)

* [Source](http://github.com/postmodern/ruby-ncrack)
* [Issues](http://github.com/postmodern/ruby-ncrack/issues)
* [Documentation](http://rubydoc.info/gems/ruby-ncrack/frames)

## Description

A Ruby interface to [ncrack], Network authentication cracking tool.

## Features

* Provides a [Ruby interface][Ncrack::Command] for running the `ncrack` utility.
* Provides a [parser][Ncrack::XML] for enumerating Ncrack XML output files.

[Ncrack::Command]: https://rubydoc.info/gems/ruby-ncrack/Ncrack/Command
[Ncrack::XML]: https://rubydoc.info/gems/ruby-ncrack/Ncrack/XML

## Examples

Running `ncrack` from Ruby:

```ruby
require 'ncrack'

Ncrack::Command.run(targets: %w[10.0.0.130:21 192.168.1.2:22], output_xml: 'ncrack.xml')
```

Parsing `ncrack` XML files:

```ruby
Ncrack::XML.open('ncrack.xml') do |xml|
  # ...
end
```

## Requirements

* [ncrack] >= 0.7
* [command_mapper](http://github.com/postmodern/command_mapper.rb#readme) ~> 0.1
* [nokogiri](https://github.com/sparklemotion/nokogiri#readme) ~> 1.0

## Install

```shell
$ gem install ruby-ncrack
```

## Copyright

Copyright (c) 2011-2021 Hal Brodigan

See {file:LICENSE.txt} for details.

[ncrack]: https://nmap.org/ncrack/
