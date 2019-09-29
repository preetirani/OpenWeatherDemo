//
//  ViewController.swift
//  Weather
//
//  Created by Preeti Rani on 24/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var humidityProgressView: ProgressView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(weather: nil)
        fetchCurrentLocation()
    }

    private func fetchCurrentLocation() {
        let locator = Locator.instance
        locator.locate { [weak self] (location, error) in
            if let loc = location {
                print("Current location's lat is \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
                self?.fetchWeather(location: loc)
            }
            if let error = error {
                print("Error received: \(error.rawValue)")
            }
        }
    }

    private func fetchWeather(location: CLLocation) {
        ApiClient.shared.fetchCurrentWeather(for: location, success: { (weather) in
            print("weather: \(weather)")
            self.setup(weather: weather)
        }) { (errorString) in
            print("Error Received: \(errorString)")
        }
    }
    
    func setup(weather: Weather?) {
        DispatchQueue.main.async { [weak self] in
            self?.currentTemperature.text = Int(weather?.temperature?.toCelsius.rounded() ?? 0).description
            self?.maxTemperatureLabel.text = Int(weather?.tempMax?.toCelsius.rounded() ?? 0).description
            self?.minTemperatureLabel.text =    Int(weather?.tempMin?.toCelsius.rounded() ?? 0).description
            self?.weatherDescriptionLabel.text  =   weather?.weatherDescription
            self?.adressLabel.text  =   weather?.address
            var progress = (weather?.humidity ?? 0)/100
            if progress < 0 { progress = 0 }
            
            self?.humidityProgressView.set(progress: Float(progress))
            self?.humidityValueLabel.text = Int(weather?.humidity ?? 0).description + "%"
            self?.windSpeedLabel.text = "Speed: \(Int(weather?.windSpeed?.rounded() ?? 0).description)"
        }
    }
}

