import Foundation
import CoreLocation


// This class allows us to manage the location of the iPhone user
//Used ObservableObject because state of the object needs to be shared across multiple views
//NSObject used to help object conform to Objective-c objects because Swfit is a compile-time based lanuage (doesnt let you change variables as you run it) Need NSObject for UIKit
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//creates manager to communicate with location services
    let manager = CLLocationManager()
    //published variables allow for updates in the observableObject
    //2d means lat and long
    @Published var location: CLLocationCoordinate2D?
    //to check if location data is being loaded in from device built in services
    @Published var isLoading = false
    //overrides the defualt class by the NSObject
    override init() {
        //All setup by NSObject is also performed here
        super.init()
        //object called manager given delegate name
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        // Request the current location from the CLLocationManager
        manager.requestLocation()
    }

    //function gets called automatically when the device location has changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    //takes in the parameter representing the locaton as well as the erro
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error getting location", error)
        isLoading = false
    }
}
