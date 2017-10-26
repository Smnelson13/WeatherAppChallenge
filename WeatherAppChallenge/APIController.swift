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

protocol APIControllerDelegate
{
  func didRecieveResults(_ results: [String: Any])
}

class APIController
{
  var delegate: APIControllerDelegate
  
  init(delegate: APIControllerDelegate)
  {
    self.delegate = delegate
  }
  
  func searchDarkSky(coordinate: CLLocationCoordinate2D)
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Westervile,oh,us&APPID=\(APIKey)")!
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
