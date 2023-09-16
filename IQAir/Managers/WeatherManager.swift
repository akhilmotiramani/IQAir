import Foundation
import CoreLocation

class WeatherManager {
    
    // Async as this takes time but get the current weather data based on latitude and longitude, responsebody is the result
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        // Define your API key for accessing weather data
        let apiKey = "c3a470cb-9166-422b-b6f5-5a01a3d86c24"
        
        // Create a URL using the latitude, longitude, and API key, if the value is nil then executes the else
        guard let url = URL(string: "https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        
        // Create URL request using the URL
        let urlRequest = URLRequest(url: url)
        
        // Sends the request to the URL
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Checks to see if request is good
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        // Decode the received JSON data into a ResponseBody object
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        // Return the decoded weather data
        return decodedData
    }
}

//codable means Swift can parse the JSON file
struct ResponseBody: Codable {
    let status: String
    let data: DataClass
}

struct DataClass: Codable {
    let city, state, country: String
    let location: Location
    let current: Current
}

struct Current: Codable {
    let pollution: Pollution
    let weather: Weather
}

struct Pollution: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}

struct Weather: Codable {
    let ts: String
    let tp, pr, hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}

struct Location: Codable {
    let type: String
    let coordinates: [Double]
}
