//
//  ToDoModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 31.01.24.
//



import Foundation

struct EarthquakeSafety: Codable {
    let title: String
    let subtitle: String?
    let precautions: [String]?
    let supplies: [String]?
    let plan: String?
    let procedures: [String]?
    let imageURL: String?
}

struct EarthquakeSafetyData: Codable {
    let earthquakeSafety: [EarthquakeSafety]
}
