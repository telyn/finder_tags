# frozen_string_literal: true

require "ffi-xattr"
require "binary_plist/parser/bplist00"
require "finder_tags/titlecase"

using FinderTags::Titlecase

class FinderTags
  Tag = Struct.new(:name, :color)
  FINDERINFO_KEY = "com.apple.FinderInfo"
  USERTAGS_KEY = "com.apple.metadata:_kMDItemUserTags"
  TAG_BYTE_OFFSET = 9

  # i could do something tricksy (color >> 1), but I don't feel like it
  # two arrays of colors is fine by me
  LEGACY_COLORS = %i[
    none none
    grey grey
    green green
    purple purple
    blue blue
    yellow yellow
    red red
    orange orange
  ].freeze
  MODERN_COLORS = %i[
    none
    grey
    green
    purple
    blue
    yellow
    red
    orange
  ].freeze

  def initialize(file)
    @file = file
  end

  def tags
    tags = extended_tags
    tags = [legacy_tag] if tags.none? && legacy_tag.color != :none
    tags
  end

  def legacy_tag
    @legacy_tag ||=
      begin
        return Tag.new("None", :none) if tag_byte.nil?

        color = LEGACY_COLORS[tag_byte.to_i]
        Tag.new(color.to_s.titlecase, color)
      end
  end

  def extended_tags
    @extended_tags ||= raw_user_tags.map(&method(:raw_to_tag))
  end

  private

  attr_reader :file

  def tag_byte
    finder_info&.unpack("x9C")&.first
  end

  def finder_info
    xattr[FINDERINFO_KEY]
  end

  def raw_user_tags
    return [] if usertags_xattr.nil?

    BinaryPList::Parser::BPList00
      .new(StringIO.new(usertags_xattr))
      .parse
  end

  def usertags_xattr
    xattr[USERTAGS_KEY]
  end

  def raw_to_tag(tag)
    name, color = tag.split("\n")
    Tag.new(name, MODERN_COLORS[color.to_i])
  end

  def xattr
    @xattr ||= Xattr.new(file)
  end
end
