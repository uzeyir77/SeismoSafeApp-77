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
    var earthquakeFeature: EarthquakeFeature
    
    init(coordinate: CLLocationCoordinate2D, earthquakeFeature: EarthquakeFeature) {
        self.coordinate = coordinate
        self.earthquakeFeature = earthquakeFeature
        super.init()
        self.title = "Magnitude: \(earthquakeFeature.properties?.mag ?? 0)" 
        self.subtitle = "Place: \(earthquakeFeature.properties?.place ?? "")\nTime: \(formattedTime(for: earthquakeFeature))"
    }
    private func formattedTime(for earthquake: EarthquakeFeature) -> String {
        guard let time = earthquake.properties?.time else {
            return ""
        }
        let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
}


