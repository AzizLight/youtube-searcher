# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youtube-searcher/version'

Gem::Specification.new do |spec|
  spec.name          = "youtube-searcher"
  spec.version       = YoutubeSearcher::VERSION
  spec.authors       = ["Aziz Light"]
  spec.email         = ["aziz@azizlight.me"]
  spec.summary       = %q{Search Youtube from the command line and download videos using `youtube-dl`.}
  spec.homepage      = "https://github.com/AzizLight/youtube-searcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "google-api-client"
end
