//
//  LocationsViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    public var selectedRetailer: Object!
    public var retailerLocations: List<Location>?
    private let locManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    var retailerName: String?
    
    @IBOutlet weak var locationsMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set retailer locations
        retailerLocations = selectedRetailer.value(forKey: "locations") as? List<Location>
        //get user location
        func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // If status has not yet been determied, ask for authorization
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse:
                // If authorized when in use
                manager.startUpdatingLocation()
                break
            case .authorizedAlways:
                // If always authorized
                manager.startUpdatingLocation()
                break
            case .restricted:
                // If restricted by e.g. parental controls. User can't enable Location Services
                break
            case .denied:
                // If user denied your app access to Location Services, but can grant access from Settings.app
                break
            }
        }
        // set region and get user location
        configureUserLocation()
        //plot locations
        plotRetailers(locations: retailerLocations!)
        // style view
        retailerName = selectedRetailer!.value(forKey: "name") as? String
        self.title = (retailerName?.uppercased())! + " LOCATIONS"
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // begin location / map view functions
    func configureUserLocation() {
        locManager.delegate = self
        // Getting user permission for location data
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startMonitoringSignificantLocationChanges()
        if locManager.location?.coordinate != nil {
            let location:CLLocationCoordinate2D = locManager.location!.coordinate
            userLocation = location
            centerMap(center: userLocation!)
        }
    }
    
    func saveCurrentLocation(center:CLLocationCoordinate2D){
        userLocation = center
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        centerMap(center: locValue)
    }
    
    func centerMap(center:CLLocationCoordinate2D) {
        self.saveCurrentLocation(center: center)
        let spanX = 0.3
        let spanY = 0.3
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        locationsMapView.setRegion(newRegion, animated: true)
    }
    
    func plotRetailers(locations: List<Location>){
        for location in locations {
            let locationLatitude = location["latitude"] as! Double
            let locationLongitude = location["longitude"] as! Double
            let locationTitle = selectedRetailer["name"] as! String
            let annotaiton = LocationAnnotation(title: locationTitle, subtitle: locationTitle, coordinate: CLLocationCoordinate2D(latitude: locationLatitude, longitude: locationLongitude))
            locationsMapView.addAnnotation(annotaiton)
        }
        
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
        {
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationIdentifier")
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
            }
            view?.canShowCallout = true
            return view
        }
    }
}
