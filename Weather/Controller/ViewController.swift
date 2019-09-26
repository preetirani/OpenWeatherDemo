//
//  ViewController.swift
//  Weather
//
//  Created by Preeti Rani on 24/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        }) { (errorString) in
            print("Error Received: \(errorString)")
        }
    }
}

