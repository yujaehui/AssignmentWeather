//
//  WeatherAPI.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import Foundation

enum WeatherAPI {
    case currentWeather(lat: Double, lon: Double)
    case weather(lat: Double, lon: Double)
    
    var baseURL: String {
        return "http://api.openweathermap.org/data/2.5/"
    }
    var appid: String {
        return ""
    }
    
    var url: URL {
        switch self {
        case .currentWeather(let lat, let lon):
            return URL(string: baseURL + "weather?lat=\(lat)&lon=\(lon)&appid=\(appid)")!
        case .weather(let lat, let lon):
            return URL(string: baseURL + "forecast?lat=\(lat)&lon=\(lon)&appid=\(appid)")!
        }
    }
}
