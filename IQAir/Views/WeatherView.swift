//
//  WeatherView.swift
//  IQAir
//
//  Created by Akhil Motiramani on 9/16/23.
import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody

    var currentTemperature: Int {
        // Convert temperature to Fahrenheit
        return Int(Double(weather.data.current.weather.tp) * 9/5 + 32)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.data.city)
                        .bold()
                        .font(.title)

                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Current Temperature:")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("\(currentTemperature)°F") // Display temperature in Fahrenheit
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Cover the bottom of the screen
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.598, saturation: 0.821, brightness: 0.701))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
