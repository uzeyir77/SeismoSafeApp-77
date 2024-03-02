//
//  ViewModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 15.01.24.
//

import Alamofire
import Foundation
import MapKit

class EartquakeViewModel  {
    var eartquakes: [EarthquakeFeature] = []
    var originalEarthquakes: [EarthquakeFeature] = []
    var coordinates = [Coordinates]()
    var allAnnotations: [MKAnnotation] = []
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getLast1HourEarthquakes() {
        NetworkManager.request(model: Earthquake.self, endpoint: Endpoints.past1HourEartquakes.rawValue) { [weak self] data, errorMessages  in
            if let errorMessages = errorMessages {
                self?.error?(errorMessages)
            } else if let data = data {
                self?.eartquakes = data.features ?? []
                self?.coordinates.removeAll()
                
                for feature in data.features ?? [] {
                    if let coordinatesList = feature.geometry?.coordinates, coordinatesList.count >= 2 {
                        self?.coordinates.append(.init(longitude: coordinatesList[0], latitude: coordinatesList[1], depth: nil))
                    }
                }
                self?.success?()
            }
        }
    }
    func getlast1DayEartquakes() {
        NetworkManager.request(model: Earthquake.self, endpoint: Endpoints.past1DayEartquakes.rawValue) { [weak self] data, errorMessages in
            if let errorMessage = errorMessages {
                self?.error?(errorMessage)
            } else if let data = data {
                self?.eartquakes = data.features ?? []
                self?.coordinates.removeAll()

//                for feature in data.features ?? [] {
//                    if let place = feature.properties?.place,
//                       let time = feature.properties?.time,
//                       let magnitude = feature.properties?.mag {
//
//                        //print("Magnitude: \(magnitude), Time: \(time), Place: \(place)")
//                    } else {
//                        print("Some properties are not available for this feature.")
//                    }
//                }
                self?.success?()
            }
        }
    }
    func search(for searchText: String) {
        let filteredEarthquakes = eartquakes.filter { earthquake in
            return earthquake.properties?.place?.lowercased().contains(searchText.lowercased()) == true
        }
        eartquakes = filteredEarthquakes
        success?()
    }
    func filterEarthquakes(byMagnitudeSegment segmentIndex: Int) -> [EarthquakeFeature] {
        let minMagnitude: Double
        let maxMagnitude: Double
        
        switch segmentIndex {
        case 0:
            minMagnitude = 0.0
            maxMagnitude = 3.0
        case 1:
            minMagnitude = 3.1
            maxMagnitude = 5.0
        case 2:
            minMagnitude = 5.1
            maxMagnitude = 10.0
        default:
            minMagnitude = 0.0
            maxMagnitude = 0.0
        }
        
        let filteredEarthquakes = eartquakes.filter { earthquake in
            if let magnitude = earthquake.properties?.mag {
                return magnitude >= minMagnitude && magnitude <= maxMagnitude
            }
            return false
        }
        
        return filteredEarthquakes
    }

    
    
    
    private func formattedTime(for feature: EarthquakeFeature) -> String {
        guard let time = feature.properties?.time else {
            return "Unknown Time"
        }
        let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
}
    
   

