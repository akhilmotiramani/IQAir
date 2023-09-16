//
//  ModelData.swift
//  IQAir
//
//  Created by Akhil Motiramani on 9/16/23.

import Foundation

var previewWeather: ResponseBody = load(filename: "weatherData.json")

func load<T: Decodable>(filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("JSON file not found in bundle. Bundle path: \(Bundle.main.bundlePath)")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
