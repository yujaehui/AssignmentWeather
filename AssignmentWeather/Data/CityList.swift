//
//  City.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import Foundation

struct CityList: Codable {
    let id: Int
    let name: String
    let state: State
    let country: Country
    let coord: CityCoord
}

enum State: String, Codable {
    case empty = ""
    case ca = "CA"
    case tx = "TX"
}

enum Country: String, Codable {
    case hk = "HK"
    case jp = "JP"
    case kr = "KR"
    case us = "US"
}

struct CityCoord: Codable {
    let lon: Double
    let lat: Double
}

func myDecoding() {
    guard let fileURL = Bundle.main.url(forResource: "CityList", withExtension: "json") else {
        print("error")
        return
    }
    do {
        // JSON 파일을 Data로 읽어들임
        let jsonData = try Data(contentsOf: fileURL)
        
        // JSONDecoder를 사용하여 JSON 데이터를 모델로 디코딩
        let decoder = JSONDecoder()
        let model = try decoder.decode([CityList].self, from: jsonData)
        print(model)
    } catch {
        print("Error decoding JSON: \(error)")
    }
}

