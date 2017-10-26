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
  @IBOutlet weak var skyconView: SKYIconView!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var chanceOfRainLabel: UILabel!
  
  var apiController: APIController!
  let locationManager = CLLocationManager()
  
  func didRecieveResults(_ results: [String : Any])
  {
    let currentWeather = Weather(weatherDictionary: results)
    let dispatchQueue = DispatchQueue.main
    dispatchQueue.async {
      self.temperatureLabel.text = "\(currentWeather.temperature.rounded())℉"
      self.skyconView.setType = Skycons(rawValue: currentWeather.icon)!
      self.summaryLabel.text = currentWeather.summary
      self.windSpeedLabel.text = "\(currentWeather.windSpeed)MPH"
      self.chanceOfRainLabel.text = "\(currentWeather.precipProbability)%"
    }
  }
  

  override func viewDidLoad()
  {
    super.viewDidLoad()
    skyconView.setColor = UIColor.white
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

