require 'json'

def read_data 
	data = File.read(Rails.root.to_s + "/app/controllers/buslines/lines.json")
end

def get_lines val, type
	lines = []
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][val]["#{type}"].each do |e|
		lines << e["num"]
	end
	return lines
end

def get_bus_company(line)
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][3]["Bus"].each do |e|
		if e["num"].to_s == line.to_s
			return e["operator"].to_s
		end
	end
end

def get_trolley_company(line)
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][2]["Trolley"].each do |e|
		if e["num"].to_s == line.to_s
			return e["operator"].to_s
		end
	end
end

def get_tram_company(line)
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][0]["Tram"].each do |e|
		if e["num"].to_s == line.to_s
			return e["operator"].to_s
		end
	end
end

def get_subway_company(line)
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][1]["Subway"].each do |e|
		if e["num"].to_s == line.to_s
			return e["operator"].to_s
		end
	end
end

def get_tram_lines
	get_lines 0, "Tram"
end

def get_subway_lines
	get_lines 1, "Subway"
end

def get_trolley_lines
	get_lines 2, "Trolley"
end

def get_bus_lines
	get_lines 3, "Bus"
end