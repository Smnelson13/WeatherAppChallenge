//
//  APIController.swift
//  WeatherAppChallenge
//
//  Created by Shane Nelson on 10/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol APIControllerDelegate: class 
{
  func didRecieveResults(_ results: [String: Any])
}

public class APIController
{
  var delegate: APIControllerDelegate
  
  init(delegate: APIControllerDelegate)
  {
    self.delegate = delegate
  }

  func searchDarkSky(coordinate: CLLocationCoordinate2D)
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let url = URL(string: "https://api.darksky.net/forecast/\(darkSkyAPIKey)/\(coordinate.latitude),\(coordinate.longitude)")!
    let session = URLSession.shared
    
    let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
      
      print("Task completed")
      if let error = error
      {
        print(error.localizedDescription)
      }
      else
      {
        if let dictionary = self.parseJSON(data!)
        {
          if let results = dictionary["currently"] as? [String: Any]
          {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //self.delegate?.didRecieveDarkSky(results) // Multiple way
            self.delegate.didRecieveResults(results)
          }
        }
      }
    })
    
    task.resume()
  }
  

  func testDelegate()
  {
    
  }
  
  
  func parseJSON(_ data: Data) -> [String: Any]?
  {
    do
    {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      if let dictionary = json as? [String: Any]
      {
        return dictionary
      }
      else
      {
        return nil
      }
    }
    catch
    {
      print(error)
      return nil
    }
  }
  
  
}


/* //http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1
 func getWeatherData(coordinate: CLLocationCoordinate2D)
 {
 UIApplication.shared.isNetworkActivityIndicatorVisible = true
 let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(APIKey)")!
 let session = URLSession.shared
 
 let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
 
 print("Task completed")
 if let error = error
 {
 print(error.localizedDescription)
 }
 else
 {
 if let dictionary = self.parseJSON(data!)
 {
 if let results = dictionary["currently"] as? [String: Any]
 {
 UIApplication.shared.isNetworkActivityIndicatorVisible = false
 self.delegate.didRecieveResults(results)
 }
 }
 }
 })
 
 task.resume()
 }*/
