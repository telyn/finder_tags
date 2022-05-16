# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "finder_tags/version"

Gem::Specification.new do |spec|
  spec.name          = "finder_tags"
  spec.version       = FinderTags::VERSION
  spec.authors       = ["Telyn Z."]
  spec.email         = ["175827+telyn@users.noreply.github.com"]

  spec.summary       = "Library & utility for reading tags from Finder.app"
  spec.homepage      = "https://github.com/telyn/finder_tags"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "binary_plist-parser", "~> 0.1.0"
  spec.add_dependency "ffi-xattr", ">= 0.1.2", "< 0.3.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "fuubar", "~> 2.5"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.19"
  spec.add_development_dependency "rubocop-rspec", "~> 2.4"
end
