# frozen_string_literal: true

require_relative "lib/compliance/owasp/version"

Gem::Specification.new do |spec|
	spec.name = "compliance-owasp"
	spec.version = Compliance::OWASP::VERSION
	
	spec.summary = "Compliance requirements for OWASP Application Security Verification Standard."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/compliance-owasp"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"source_code_uri" => "https://github.com/ioquatix/compliance-owasp.git",
	}
	
	spec.files = Dir.glob(['{compliance,lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
end
