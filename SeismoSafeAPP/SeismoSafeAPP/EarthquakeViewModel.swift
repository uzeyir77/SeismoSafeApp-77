//
//  ViewModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 15.01.24.
//

import Alamofire

class EartquakeViewModel  {
    var eartquakes: [EarthquakeFeature] = []
    
    var coordinates = [Coordinates]()
    
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
    func getlast1DayEartquakes(){
        NetworkManager.request(model: Earthquake.self, endpoint: Endpoints.past1DayEartquakes.rawValue) { [weak self] data, errorMessages in
            if let errorMessage = errorMessages {
                self?.error?(errorMessage)
            }else if let data = data {
                self?.eartquakes = data.features ?? []
                self?.coordinates.removeAll()
                for feature in data.features ?? []{
                    if let coordinatesList = feature.geometry?.coordinates , coordinatesList.count >= 2 {
                        self?.coordinates.append(.init(longitude: <#T##Double?#>, latitude: <#T##Double?#>, depth: <#T##Double?#>))
                    }
                }
            }
        }
    }
}
