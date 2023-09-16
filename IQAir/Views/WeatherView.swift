import SwiftUI
import MapKit

struct WeatherView: View {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var weather: ResponseBody

    // Calculate and return the current temperature in Fahrenheit
    var currentTemperature: Int {
        return Int(Double(weather.data.current.weather.tp) * 9/5 + 32)
    }

    var airQualityIndex: Int {
        return Int(Double(weather.data.current.pollution.aqius))
    }

    var backgroundColor: Color {
        //date object to hold current date and time
        let now = Date()
        //create a calender object with current settings
        let calendar = Calendar.current
        //get current hour number
        let hour = calendar.component(.hour, from: now)

        if (6...11).contains(hour) {
            return Color.orange
        } else if (12...18).contains(hour) {
            return Color.blue
        } else {
            return Color.black
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    // Display the city name
                    Text(weather.data.city)
                        .bold()
                        .font(.title)
                    // Display the state name
                    Text(weather.data.state)
                        .bold()
                        .font(.title)
                    // Display the country name
                    Text(weather.data.country)
                        .bold()
                        .font(.title)

                    // Display the current date and time
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        // Display a label for current temperature
                        Text("Current Temperature:")
                            .font(.title)
                            .fontWeight(.bold)

                        // Display the current temperature in Fahrenheit
                        Text("\(currentTemperature)°F")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 20) {
                        // Display a label for the air quality index
                        Text("Current Air Quality Index:")
                            .font(.title)
                            .fontWeight(.bold)

                        // Display the current air quality index
                        Text("\(airQualityIndex)")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Add a Map view based on latitude and longitude
                //.constant does not allow you to modify the region
                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: latitude,
                            longitude: longitude
                        ),
                        //span for the map view
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                ))
                
                .frame(height: 200)
                .cornerRadius(10)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
        }
        .background(backgroundColor)
        //allows the content to flow all the way to the bottom
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}
