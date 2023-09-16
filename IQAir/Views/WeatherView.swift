import SwiftUI
import MapKit // Import MapKit

struct WeatherView: View {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var weather: ResponseBody

    var currentTemperature: Int {
        // Convert temperature to Fahrenheit
        return Int(Double(weather.data.current.weather.tp) * 9/5 + 32)
    }
    
    var airQualityIndex: Int {
        // Convert temperature to Fahrenheit
        return Int(Double(weather.data.current.pollution.aqius))
    }
    
    // Computed property to calculate the background color based on the time of day
    var backgroundColor: Color {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        
        // Define the color based on the time of day
        if (6...11).contains(hour) {
            return Color.orange // Morning color
        } else if (12...18).contains(hour) {
            return Color.blue // Afternoon color
        } else {
            return Color.black // Nighttime color
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.data.city)
                        .bold()
                        .font(.title)
                    Text(weather.data.state)
                        .bold()
                        .font(.title)
                    Text(weather.data.country)
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
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Current Air Quality Index:")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(airQualityIndex)")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Add a Map view based on latitude and longitude
                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: latitude, // Use the passed latitude
                            longitude: longitude // Use the passed longitude
                        ),
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
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}
