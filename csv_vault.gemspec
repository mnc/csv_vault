
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_vault/version"

Gem::Specification.new do |spec|
  spec.name          = "csv_vault"
  spec.version       = CsvVault::VERSION
  spec.authors       = ["mnc"]
  spec.email         = ["manchose9@gmail.com"]

  spec.summary       = %q{CsvVault is a Ruby gem to encrypt/decrypt CSV.}
  spec.description   = %q{CsvVault is a Ruby gem to encrypt/decrypt CSV. You can specify target columns to encrypt/decrypt.}
  spec.homepage      = "https://github.com/mnc/csv_vault"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  # TODO: dependency version check
  spec.add_runtime_dependency "activesupport", "~> 4"
  spec.add_runtime_dependency "thor", "~> 0.20.3"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
