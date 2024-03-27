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
        self.subtitle = "Place: \(earthquakeFeature.properties?.place ?? "")\nTime: \(EarthquakeFeatureAdapter.formattedTime(for: earthquakeFeature))"
    }
}


