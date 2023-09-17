import SwiftUI

struct ContentView: View {
    // Creates a new locationManager instance specific to only this view 
    @StateObject var locationManager = LocationManager()
    
    // Create an instance of WeatherManager
    var weatherManager = WeatherManager()
    
    // Used a state because the data is used to observe the data locally and does not need to be updated
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    // Weatherview shows all three categories
                    WeatherView(latitude: location.latitude, longitude: location.longitude, weather: weather)
                } else {
                    //Shows loading view if unable to gather data
                    LoadingView()
                    //Async task to not interupt current processes
                        .task {
                            do {
                                // Trys to get data again
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                //if exception, print error
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                //In case the data has not loaded in yet
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    //Keep showing the welcome view
                    WelcomeView()
                        .environmentObject(locationManager) // Inject the LocationManager as an environment object
                }
            }
        }
        // Set a gradient background
        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.blue]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the ContentView
        ContentView()
    }
}
