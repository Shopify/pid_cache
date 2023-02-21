# frozen_string_literal: true

require_relative "lib/pid_cache/version"

Gem::Specification.new do |spec|
  spec.name = "pid_cache"
  spec.version = PIDCache::VERSION
  spec.authors = ["Jean Boussier"]
  spec.email = ["jean.boussier@gmail.com"]

  spec.summary = "Cache calls to Process.pid"
  spec.description = "On platforms using glibc 1.25+ Process.pid always issue a syscall which is wasteful. pid_cache prevents that."
  spec.homepage = "https://github.com/Shopify/pid_cache"
  spec.license = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = File.join(spec.homepage, "blob/master/CHANGELOG.md")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
