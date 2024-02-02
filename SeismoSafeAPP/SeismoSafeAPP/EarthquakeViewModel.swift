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
                for feature in data.features ?? [] {
                    if let coordinatesList = feature.geometry?.coordinates, coordinatesList.count >= 2 {
                        let magnitude = feature.properties?.mag ?? 0.0
                        //let time = self?.formattedTime(for: feature) ?? "Unknown Time"
                        let place = feature.properties?.place ?? "Unknown Place"
                        print("Magnitude: \(magnitude), Time: (time), Place: \(place)")
                        self?.coordinates.append(.init(longitude: coordinatesList[0], latitude: coordinatesList[1], depth: nil))
                        
                        print("Magnitude: \(magnitude),  Place: \(place)")
                    } else {
                        print("Coordinates are not available for this feature.")
                    }
                }
                self?.success?()
            }
        }
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
    
   

