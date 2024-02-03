//
//  ModelEarthquake.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 16.01.24.
//

import Foundation

// MARK: - Earthquake
struct Earthquake: Codable {
    let features: [EarthquakeFeature]?
}

// MARK: - EarthquakeFeature
struct EarthquakeFeature: Codable {
    let type: String?
    let properties: Properties?
    let geometry: Geometry?
    let id: String?
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String?
    let coordinates: [Double]?
}

// MARK: - Properties
struct Properties: Codable {
    let mag: Double?
    let place: String?
    let time, updated: Int?
    let url: String?
    let detail: String?
    let status: String?
    let types: String?
    let magType, type, title: String?
}

struct Coordinates: Codable {
    let longitude: Double?
    let latitude: Double?
    let depth: Double?
}
