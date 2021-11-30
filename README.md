# ruby-ncrack

[![CI](https://github.com/postmodern/ruby-ncrack/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/ruby-ncrack/actions/workflows/ruby.yml)
[![Gem Version](https://badge.fury.io/rb/ruby-ncrack.svg)](https://badge.fury.io/rb/ruby-ncrack)

* [Source](http://github.com/postmodern/ruby-ncrack)
* [Issues](http://github.com/postmodern/ruby-ncrack/issues)
* [Documentation](http://rubydoc.info/gems/ruby-ncrack/frames)

## Description

A Ruby interface to [ncrack], Network authentication cracking tool.

## Features

* Provides a Ruby interface for running `ncrack`.

## Examples

```ruby
require 'ncrack'

Ncrack::Command.run(targets: %w[10.0.0.130:21 192.168.1.2:22])
```

## Requirements

* [ncrack] >= 0.7
* [command_mapper](http://github.com/postmodern/command_mapper.rb#readme) ~> 0.1

## Install

```shell
$ gem install ruby-ncrack
```

## Copyright

Copyright (c) 2011-2021 Hal Brodigan

See {file:LICENSE.txt} for details.

[ncrack]: https://nmap.org/ncrack/
