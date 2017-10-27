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

  //Responsible for obtaining Weather news form the API
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
  
  // parses JSON data from the API
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

