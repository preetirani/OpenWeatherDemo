//
//  MapViewController.swift
//  Weather
//
//  Created by preeti rani on 28/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func fetchCurrentLocation() {
        let locator = Locator.instance
        locator.locate { [weak self] (location, error) in
            if let loc = location {
                print("Current location's lat is \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
                self?.loadMap(location: loc)
            }
            if let error = error {
                print("Error received: \(error.rawValue)")
            }
        }
    }
    
    func loadMap(location: CLLocation) {
        let urlString = "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=clouds&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&zoom=3"
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

}

extension MapViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
}
