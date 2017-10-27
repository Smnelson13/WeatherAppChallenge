//
//  SearchViewController.swift
//  WeatherAppChallenge
//
//  Created by Shane Nelson on 10/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate
{
  func searchViewControllerDidRecieveLocation(coordinate: CLLocationCoordinate2D)
}

class SearchViewController: UIViewController, UISearchBarDelegate
{
  @IBOutlet weak var poweredByImage: UIImageView!
  var delegate: SearchViewControllerDelegate!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var doneButton: UIButton!
  @IBAction func xButton(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad()
    {
      super.viewDidLoad()
      view.backgroundColor = UIColor.white
      searchBar.delegate = self
      searchBar.showsCancelButton = true
      searchBar.barTintColor = customBlue
      doneButton.backgroundColor = customBlue
      doneButton.layer.cornerRadius = 20
      poweredByImage.image = poweredByImage.image!.withRenderingMode(.alwaysTemplate)
      poweredByImage.tintColor = customBlue
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
  {
    searchBar.showsCancelButton = true
    
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
  {
    searchBar.text = nil
    searchBar.showsCancelButton = false
    searchBar.endEditing(true)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  {
    performGeocode(text: searchBar.text)
  }
  
  func performGeocode(text: String?)
  {
    guard let text = text, text != "" else
    {
      return
    }
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(text)
    { placemarks, error in
      if let coordinate = placemarks?.first?.location?.coordinate
      {
        self.delegate.searchViewControllerDidRecieveLocation(coordinate: coordinate)
      }
    }
  }
  
  
}
