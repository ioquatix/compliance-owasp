
# Generate a JSON file containing the ASVS requirements.
# @parameter level [String] The level of the ASVS to convert.
def generate(level: "L1")
	input_path = File.expand_path("source/OWASP_Application_Security_Verification_Standard-5_en.json", __dir__)
	input = JSON.load_file(input_path)
	
	output_path = File.expand_path("compliance/OWASP-ASVS-5.0-#{level}.json", __dir__)
	
	requirements = []
	
	extract(input["Requirements"], level) do |requirement, scope|
		shortcode = requirement["Shortcode"]
		
		id = "OWASP-ASVS-#{shortcode}"
		description = requirement["Description"]
		
		description.sub!(/\[.*?\]\s*/, "")
		
		requirements << {
			"id" => id,
			"scope" => scope,
			"description" => description,
		}
	end
	
	File.open output_path, "w" do |file|
		file.puts JSON.pretty_generate(requirements: requirements)
	end
end

def generate_all
	["L1", "L2", "L3"].each do |level|
		generate(level: level)
	end
end

private

def extract(input, level, scope: [], &block)
	if input.is_a?(Array)
		input.each do |item|
			extract(item, level, scope: scope.dup, &block)
		end
	elsif items = input["Items"]
		if name = input["Name"]
			scope << name
		end
		
		items.each do |item|
			extract(item, level, scope: scope.dup, &block)
		end
	else
		if input[level]["Required"]
			yield input, scope
		end
	end
end
