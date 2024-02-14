//
//  WeatherAPIManager.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import Foundation
import Alamofire

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() {}
    
    func request<T: Decodable>(type: T.Type, api: WeatherAPI, completionHandler: @escaping (T) -> Void) {
        AF.request(api.url).responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
