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
    let time, updated, tz: Int?
    let url: String?
    let detail: String?
    let felt: Int?
    let cdi, mmi: Decimal?
    let alert, status: String?
    let tsunami, sig: Int?
    let net, code, ids, sources: String?
    let types: String?
    let nst: Int?
    let dmin, rms: Double?
    let gap: Int?
    let magType, type, title: String?
}

struct Coordinates: Codable {
    let longitude: Double?
    let latitude: Double?
    let depth: Double?
}
