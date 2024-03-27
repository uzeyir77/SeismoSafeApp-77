//
//  EarthquakeFeatureAdapter .swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 26.03.24.
//

import Foundation
class EarthquakeFeatureAdapter {
    static func formattedTime(for feature: EarthquakeFeature)->String{
        guard let time  = feature.properties?.time else {
            return "unknown time"
        }
        let date  = Date(timeIntervalSince1970: TimeInterval(time/1000))
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dataFormatter.timeZone = TimeZone(identifier: "UTC")
        return dataFormatter.string(from: date)
    }
}
