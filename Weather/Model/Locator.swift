//
//  File.swift
//  Weather
//
//  Created by Preeti Rani on 25/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocatorDelegate {
    func didUpdateLocation(location: CLLocation)
}

enum LocationError: String {
    case Unavailable = "Location is not available at this moment."
    case Denied = "Allow us to access your location."
    case LocationServicesNotEnabled = "Please turn on location services in your settings."
}

typealias LocationClosure = ((CLLocation?, LocationError?) -> Void)?

class Locator: NSObject, CLLocationManagerDelegate {
    private var locationManager:CLLocationManager!
    private var onLocation: LocationClosure = nil
    private static var singleton: Locator?
    
    var delegate: LocatorDelegate?
    
    static var instance: Locator {
        if singleton == nil {
            singleton = Locator()
        }
        return singleton!
    }

    
    func locate(_ onLocation: LocationClosure = nil) {
        self.onLocation = onLocation
        
        guard CLLocationManager.authorizationStatus() != .notDetermined else {
            startUpdatingLocation()
            return
        }
        
        guard CLLocationManager.locationServicesEnabled() else {
            onLocation?(nil, LocationError.LocationServicesNotEnabled)
            return
        }
        
        guard CLLocationManager.authorizationStatus() != .denied else {
            onLocation?(nil, LocationError.Denied)
            return
        }
        
        startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    static func havePermission() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("have")
            return true
        default:
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        delegate?.didUpdateLocation(location: userLocation)
        
        if let onLocation = self.onLocation {
            onLocation(userLocation, nil)
            self.onLocation = nil
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if error.code == 1 {
            self.onLocation?(nil, LocationError.Denied)
        } else {
            onLocation?(nil, LocationError.Unavailable)
        }
        self.onLocation = nil
    }
    
    func openSettings() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsUrl)
    }
}
