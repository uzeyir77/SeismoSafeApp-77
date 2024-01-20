//
//  Endpoints.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 16.01.24.
//

import Foundation

enum Endpoints: String{
    case past1HourEartquakes = "earthquakes/feed/v1.0/summary/all_hour.geojson"
    case past1DayEartquakes = "earthquakes/feed/v1.0/summary/all_day.geojson"
    case past1WeekEartquakes = "earthquakes/feed/v1.0/summary/all_week.geojson"
    case past1MonthEartquakes = "uzn"
    
    
}


