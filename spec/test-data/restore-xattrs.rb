#!/bin/ruby
# frozen_string_literal: true

require "ffi-xattr"

def clear_all_xattrs
  Dir["#{__dir__}/*"].each do |file|
    xattrs = Xattr.new(file)
    xattrs.each do |key|
      xattrs.remove(key)
    end
  end
end

# Class which restores xattrs from a file created using `xattr -lrx > filename`
# on a mac. It may or may not need to run on a mac, I have no idea.
class XattrLoader
  def initialize(xattrs_file)
    @fh = File.open(xattrs_file, "r")
  end

  # rubocop:disable Metrics/MethodLength
  def load_xattrs
    @fh.each do |line|
      case line
      when /^([^:]+): (.+):/
        commit_data
        _, @fname, @key = Regexp.last_match.to_a
        @data = ""
      when /\d{8} (.+) +\|+.+\|/
        raise "no filename to put this data in" unless @fname && @key

        @data += read_hex(Regexp.last_match[1])
      end
    end
    commit_data
  end
  # rubocop:enable Metrics/MethodLength

  private

  def commit_data
    if @fname && @data && @key
      xattr = Xattr.new(File.join(__dir__, @fname))
      xattr[@key] = @data
    end
    @key, @fname, @data = nil
  end

  def read_hex(hex_strs)
    hex_strs.split.map { |x| x.to_i(16) }.pack("C*")
  end
end

RSpec.configure do |config|
  config.before(:each) do
    next if ENV["TRAVIS"]

    clear_all_xattrs
    XattrLoader.new("#{__dir__}/xattrs").load_xattrs
  end
end
