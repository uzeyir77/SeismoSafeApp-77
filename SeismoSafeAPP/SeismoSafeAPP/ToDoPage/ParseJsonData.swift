//
//  ToDoViewModel.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 31.01.24.
//

import Foundation

class ParseJsonData {
    var safetyData: EarthquakeSafety?
    
    func parseJsonFile() {
        if let file = Bundle.main.url(forResource: "todolist", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                safetyData = try JSONDecoder().decode(EarthquakeSafety.self, from: data)
                print("JSON Parse Success")
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        } else {
            print("JSON file not found.")
        }
    }
}
