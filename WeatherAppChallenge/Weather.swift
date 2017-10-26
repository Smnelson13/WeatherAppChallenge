//
//  Weather.swift
//  WeatherAppChallenge
//
//  Created by Shane Nelson on 10/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation


class Weather
{
  
  let precipProbability: Double
  let temperature: Double
  let humidity: Double
  let apparentTemperature: Double
  let icon: String
  let summary: String
  let windSpeed: Double
  let visibility: Double
  
  init(weatherDictionary: [String: Any])
  {
    precipProbability = weatherDictionary["precipProbability"] as! Double
    temperature = weatherDictionary["temperature"] as! Double
    humidity = weatherDictionary["humidity"] as! Double
    apparentTemperature = weatherDictionary["apparentTemperature"] as! Double
    icon = weatherDictionary["icon"] as! String
    summary = weatherDictionary["summary"] as! String
    windSpeed = weatherDictionary["windSpeed"] as! Double
    visibility = weatherDictionary["visibility"] as! Double
  }

}
