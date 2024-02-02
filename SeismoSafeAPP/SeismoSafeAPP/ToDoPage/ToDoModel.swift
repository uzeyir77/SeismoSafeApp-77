//
//  ToDoModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 31.01.24.
//



import Foundation
struct SafetyDetail: Codable {
    let title: String
    let subtitle: String?
    let details: [String]
    let imageURL: String?
}

// EarthquakeSafety model
struct EarthquakeSafety: Codable {
    let earthquakeSafety: [SafetyDetail]
}


