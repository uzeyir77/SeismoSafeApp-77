//
//  ViewModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 15.01.24.
//

import Alamofire

class EartquakeViewModel  {
    
    var eartquakes : [Earthquake] = []
    var success:(()-> Void)?
    var error: ((String)->Void)?
    
    func getlast1HourEarthquakes(){
        NetworkManager.request(model: Earthquake.self, endpoint: Endpoints.past1HourEartquakes.rawValue) { data, errorMessages  in
            if let errorMessages{
                self.error?(errorMessages)
            }else if let data = data {
                let earthquake = data
                let coordinates = Coordinates(
                    longitude: earthquake.geometry.coordinates[0],
                    latitude: earthquake.geometry.coordinates[1],
                    depth: earthquake.geometry.coordinates[2]
                )
                
                
                
            }
        }
        
    }
        
    
    
    
    
    
    }
