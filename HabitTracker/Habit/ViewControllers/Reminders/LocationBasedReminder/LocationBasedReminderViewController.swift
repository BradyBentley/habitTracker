//
//  LocationBasedReminderViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/18/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationBasedReminderViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationSearchBar.layer.shadowColor = UIColor.darkGray.cgColor
        locationSearchBar.layer.shadowRadius = 2
        locationSearchBar.layer.shadowOffset = CGSize(width: 2, height: 2)
        locationSearchBar.layer.shadowOpacity = 0.4
        
        saveButton.layer.shadowColor = UIColor.darkGray.cgColor
        saveButton.layer.shadowRadius = 2
        saveButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        saveButton.layer.shadowOpacity = 0.4
//        button.backgroundColor = UIColor.greenColor()
//        saveButton.layer.backgroundColor = UIColor.blue.cgColor
        
        locationSearchBar.delegate = self
        if CLLocationManager.locationServicesEnabled() == true {
            locationManager.desiredAccuracy = 0.1
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestAlwaysAuthorization()
                
            }
        } else {
            print("Please turn on location services")
        }
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        
        mapView.addGestureRecognizer(longPressRecognizer)
        mapView.isUserInteractionEnabled = true
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    var habit: Habit?
    var savedCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    @IBAction func mapSaveButtonTapped(_ sender: Any) {
        guard let savedCoordinate = savedCoordinate, let habit = habit else { return }
        let locationReminder = LocationReminder(latitude: Float(savedCoordinate.latitude), longitude: Float(savedCoordinate.longitude), reminderText: "")
        habit.locationReminder?.append(locationReminder)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Button actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        locationSearchBar.resignFirstResponder()
        print("Searching...", locationSearchBar.text!)
            
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationSearchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = self.locationSearchBar.text!
                self.savedCoordinate = annotation.coordinate
                
                self.mapView.addAnnotation(annotation)
                self.mapView.selectAnnotation(annotation, animated: false)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                let region = MKCoordinateRegion(center: (placemark?.location?.coordinate)!, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.began) {
            let longPressPoint = recognizer.location(in: mapView)
            let coordinate = mapView.convert(longPressPoint, toCoordinateFrom: mapView)
            savedCoordinate = coordinate
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            let allPreviousAnnotations = self.mapView.annotations
            if !allPreviousAnnotations.isEmpty{
                self.mapView.removeAnnotations(allPreviousAnnotations)
            }
            mapView.addAnnotation(pointAnnotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let usersLocation = locations.first else {return}
        
        let center = usersLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }

}
