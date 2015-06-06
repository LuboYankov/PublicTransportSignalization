require 'json'

def read_data 
	data = File.read(Rails.root.to_s + "/app/controllers/buslines/lines.json")
end

def get_bus_lines
	bus_lines = []
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][3]["Bus"].each do |e|
		bus_lines << e["num"]
	end
	return bus_lines
end

def get_tram_lines
	tram_lines = []
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][0]["Tram"].each do |e|
		tram_lines << e["num"]
	end
	return tram_lines
end

def get_subway_lines
	subway_lines = []
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][1]["Subway"].each do |e|
		subway_lines << e["num"]
	end
	return subway_lines
end

def get_trolley_lines
	trolley_lines = []
	hash = JSON.parse read_data
	hash["public_transport"]["Service"][2]["Trolley"].each do |e|
		trolley_lines << e["num"]
	end
	return trolley_lines
end