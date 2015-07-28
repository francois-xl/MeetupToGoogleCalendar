# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MeetupToGoogleCalendar/version'

Gem::Specification.new do |spec|
  spec.name          = "MeetupToGoogleCalendar"
  spec.version       = MeetupToGoogleCalendar::VERSION
  spec.authors       = ["Francois-Xavier LAHITTE"]
  spec.email         = ["francoisxavier.lahitte@gmail.com"]

  spec.summary       = %q{Copy Meetup public event to a Google Calendar.}
  spec.description   = %q{Allow to retreive a list of public event from a Meetup group and add these event to an authorized Google Calendar.}
  spec.homepage      = "Local dev"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"

  spec.add_development_dependency "rmeetup"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
