//
//  ModelEarthquake.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 16.01.24.
//

import Foundation

struct Earthquake: Codable {
    struct Metadata: Codable {
        let generated: Int
        let url: String
        let title: String
        let status: Int
        let api: String
        let count: Int
    }
    
    struct Properties: Codable {
        let mag: Double
        let place: String
        let time: Int
        let updated: Int
        let url: String
        let detail: String
        let status: String
        let tsunami: Int
        let sig: Int
        let net: String
        let code: String
        let ids: String
        let sources: String
        let types: String
        let nst: Int?
        let dmin: Double?
        let rms: Double
        let gap: Double?
        let magType: String
        let type: String
        let title: String
    }
    
    struct Geometry: Codable {
        let type: String
        let coordinates: [Double]
    }
    
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String

    var coordinates: Coordinates {
        return Coordinates(longitude: geometry.coordinates[0],
                           latitude: geometry.coordinates[1],
                           depth: geometry.coordinates[2])
    }
}

struct Coordinates: Codable {
    let longitude: Double
    let latitude: Double
    let depth: Double
}


let eartquake = Earthquake.self


