//
//  ApiClientService.swift
//  Weather
//
//  Created by Preeti Rani on 25/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import CoreLocation
struct ApiClient {
    let AppID = "bc5dca95b933e0545148c73f53240cb3"
    static let shared = ApiClient()
    private init(){}
    func fetchCurrentWeather(for location: CLLocation, success: @escaping (_ weatherData: Weather?) -> Void, failure: @escaping (_ error: String) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(AppID)"
        print("URL: \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode else {
                failure("ERROR!!")
                return
            }
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                failure("Json Parsing error")
                return
            }
            let weather = Weather(json: json)
            success(weather)
            
        }.resume()
    }
    
    func weatherMap(for location: CLLocation, success: @escaping (_ weatherData: Weather?) -> Void, failure: @escaping (_ error: String) -> Void) {
//        https://tile.openweathermap.org/map/{layer}/{z}/{x}/{y}.png?appid={api_key}
    }
}

