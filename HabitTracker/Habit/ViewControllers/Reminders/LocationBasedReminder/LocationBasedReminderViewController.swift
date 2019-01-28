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

class LocationBasedReminderViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, LocationReminderScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        enableLocationServices()
        
        locationManager.delegate = self
        locationSearchBar.delegate = self
        mapView.delegate = self
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    var habit: Habit?
    var savedCoordinate: CLLocationCoordinate2D?
    var savedLocationName: String?
    var locationManager = CLLocationManager()
    var geoFenceRadius: Double = 200
    var circle: MKCircle?
    
    // MARK: Update view
    
    func updateView() {
        locationSearchBar.layer.shadowColor = UIColor.darkGray.cgColor
        locationSearchBar.layer.shadowRadius = 2
        locationSearchBar.layer.shadowOffset = CGSize(width: 2, height: 2)
        locationSearchBar.layer.shadowOpacity = 0.4
        locationSearchBar.backgroundImage = UIImage()
        
        saveButton.layer.shadowColor = UIColor.darkGray.cgColor
        saveButton.layer.shadowRadius = 2
        saveButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        saveButton.layer.shadowOpacity = 0.4
        
        // Add gesture recognizer to map view
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: Gesture recognizer
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.began) {
            let longPressPoint = recognizer.location(in: mapView)
            let coordinate = mapView.convert(longPressPoint, toCoordinateFrom: mapView)
            savedCoordinate = coordinate
            // Remove all previous marks and add current ones
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            let allPreviousAnnotations = self.mapView.annotations
            let allOverlays = self.mapView.overlays
            if !allPreviousAnnotations.isEmpty {
                self.mapView.removeAnnotations(allPreviousAnnotations)
                self.mapView.removeOverlays(allOverlays)
            }
            mapView.addAnnotation(pointAnnotation)
            let circle = MKCircle(center: coordinate, radius: geoFenceRadius)
            self.mapView.addOverlay(circle)
            
            saveButton.backgroundColor = .green
            saveButton.titleLabel?.textColor = .black
        }
    }
    
    // MARK: - Location services
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestAlwaysAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            let alertController = UIAlertController(title: "Location Service Disabled", message: "Please go to Settings and turn on always enabled to receive location based alerts", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (_) in })
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            self.present(alertController, animated: true, completion: nil)
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            break
            
        case .authorizedAlways:
            // Enable all location features
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func mapSaveButtonTapped(_ sender: Any) {
        guard let savedCoordinate = savedCoordinate, let habit = habit else { return }
        if let savedLocationName = locationSearchBar.text {
            let locationReminder = LocationReminder(latitude: savedCoordinate.latitude, longitude: savedCoordinate.longitude, locationName: savedLocationName, remindOnEntryOrExit: segmentControl.selectedSegmentIndex, reminderText: "")
            habit.locationReminder.append(locationReminder)
            scheduleUserNotifications(for: locationReminder)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Search bar delegate
    
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
                
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: (placemark?.location?.coordinate)!, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    // MARK: - CLLocation manager delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableLocationServices()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let usersLocation = locations.first else { return }
        let center = usersLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited region")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    
    // MARK: - MKMap view delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            view.canShowCallout = true
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = .blue
        circle.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.05)
        circle.lineWidth = 1
        return circle
    }
    
}
