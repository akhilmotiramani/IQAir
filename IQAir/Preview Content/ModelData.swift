import Foundation
//previewWeather will store the weather data
var previewWeather: ResponseBody = load(filename: "weatherData.json")

func load<T: Decodable>(filename: String) -> T {
//stores contents of the data
    let data: Data

    // get the specific file name or will throw an error
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("JSON file not found in bundle. Bundle path: \(Bundle.main.bundlePath)")
    }

    do {
        // try to read the contents
        data = try Data(contentsOf: file)
    } catch {
        // If an error occurs while reading the file, terminate with a fatal error message.
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        // Create a JSON decoder to parse the data.
        let decoder = JSONDecoder()
        
        // put the data into a data type of T
        return try decoder.decode(T.self, from: data)
    } catch {
        // If an error occurs during JSON decoding, terminate with a fatal error message.
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
