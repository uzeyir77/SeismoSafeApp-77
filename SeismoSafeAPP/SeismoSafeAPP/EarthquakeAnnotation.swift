//
//  EarthquakeAnnotation.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 16.01.24.
//

import Foundation
import MapKit

class EarthquakeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var earthquake: Earthquake

    init(coordinate: CLLocationCoordinate2D, earthquake: Earthquake) {
        self.coordinate = coordinate
        self.earthquake = earthquake
        self.title = "Magnitude: \(earthquake.properties.mag)"
        super.init()
        self.subtitle = "Place: \(earthquake.properties.place)\nTime: \(formattedTime(for: earthquake))"
    }

    private func formattedTime(for earthquake: Earthquake) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(earthquake.properties.time / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
}
