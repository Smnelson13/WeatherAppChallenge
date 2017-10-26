//
//  ViewController.swift
//  WeatherAppChallenge
//
//  Created by Shane Nelson on 10/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, APIControllerDelegate, CLLocationManagerDelegate
{
  @IBOutlet weak var temperatureLabel: UILabel!
  
  var apiController: APIController!
  let locationManager = CLLocationManager()
  
  func didRecieveResults(_ results: [String : Any])
  {
    let currentWeather = Weather(weatherDictionary: results)
    let dispatchQueue = DispatchQueue.main
    dispatchQueue.async {
      self.temperatureLabel.text = "\(currentWeather.temperature.rounded())℉"
    }
  }
  

  override func viewDidLoad()
  {
    super.viewDidLoad()
    view.backgroundColor = customBlue
    apiController = APIController(delegate: self)
    loadCurrentLocation()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }

  
  func loadCurrentLocation()
  {
    configureLocationManager()
  }
  
  func configureLocationManager()
  {
    if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.restricted
    {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
      if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined
      {
        locationManager.requestWhenInUseAuthorization()
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
  {
    if status == CLAuthorizationStatus.authorizedWhenInUse
    {
      locationManager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    locationManager.stopUpdatingLocation()
    if let location = locations.last
    {
      apiController.searchDarkSky(coordinate: location.coordinate)
    }
  }
  
  

}

