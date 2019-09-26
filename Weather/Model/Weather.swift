//
//  File.swift
//  Weather
//
//  Created by Preeti Rani on 24/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import Foundation
protocol JsonParser {
    typealias JSON = [String: Any]
    /* toJson
     this variable returns object in the form of json.
     */
//    var toJSON: JSON {get}
    
    /* fromJSON
     converts json into object.
     */
//    static func fromJSON(json: JSON?) -> Parser?
    init(json: JSON)
}

struct Location {
    var lat: Double
    var longitude: Double
    var city: String
    var countryCode: String
}

struct Weather: JsonParser {
    var temperature: Double
    var pressure: Double
    var humidity: Double
    var tempMin: Double
    var tempMax: Double
    var seaLevel: Double
    var groundLevel: Double
    
    init(json: JSON) {
        print(json)
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
    }
}
