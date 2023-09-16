import Foundation

extension Double{
    //Used to help round various numbers to no decimal places
    func roundDouble() -> String{
        return String(format: "%.0f", self)
    }
}
