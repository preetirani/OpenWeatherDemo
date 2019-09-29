//
//  File.swift
//  Weather
//
//  Created by Preeti Rani on 24/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import Foundation
extension Double {
    var toCelsius: Double {
        return (self - 32)/1.8
    }
}

protocol JsonParser {
    typealias JSON = [String: Any]
    init(json: JSON)
}

struct Location {
    var lat: Double
    var longitude: Double
    var city: String
    var countryCode: String
}

struct Weather: JsonParser {
    var temperature: Double?
    var pressure: Double?
    var humidity: Double?
    var tempMin: Double?
    var tempMax: Double?
    var seaLevel: Double?
    var groundLevel: Double?
    var address: String?
    var windSpeed: Double?
    var weatherDescription: String?
    
    
    init(json: JSON) {
        print(json)
        self.address = json[Constants.Name] as? String
        let windJson = json[Constants.Wind] as? JSON
        self.windSpeed = windJson?[Constants.WindSpeed] as? Double
        let weather = json[Constants.Weather] as? [JSON]
        self.weatherDescription = weather?[0][Constants.WeatherDescription] as? String
        
        let main = json[Constants.Main] as? JSON
        self.temperature    =   main?[Constants.Temperature] as? Double
        self.pressure       =   main?[Constants.Pressure]    as? Double
        self.humidity       =   main?[Constants.Humidity]    as? Double
        self.tempMin        =   main?[Constants.TempMin]     as? Double
        self.tempMax        =   main?[Constants.TempMax]     as? Double
        self.seaLevel       =   main?[Constants.SeaLevel]    as? Double
        self.groundLevel    =   main?[Constants.GroundLevel] as? Double
    }
    
    
}

extension Weather {
    struct Constants {
        static let Temperature  = "temp"
        static let Pressure     = "pressure"
        static let Humidity     = "humidity"
        static let TempMin      = "temp_min"
        static let TempMax      = "temp_max"
        static let SeaLevel     = "sea_level"
        static let GroundLevel  = "grnd_level"
        static let Main         = "main"
        static let Name         = "name"
        static let Wind         = "wind"
        static let WindSpeed    = "speed"
        static let Weather      = "weather"
        static let WeatherDescription   =   "main"
    }
}
