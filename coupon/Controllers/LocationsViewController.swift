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


class LocationsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    public var selectedRetailer: Object!
    public var retailerLocations: List<Location>?
    
    var locationManager:CLLocationManager?
    let distanceSpan:Double = 500
    var lastLocation: CLLocation?
    
    @IBOutlet weak var locationsMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set retailer locations
        retailerLocations = selectedRetailer.value(forKey: "locations") as? List<Location>
        // set map view delegate
        if let mapView = self.locationsMapView {
            mapView.delegate = self
        }
        // Do any additional setup after loading the view.
        //plot locations
        plotRetailers(locations: retailerLocations!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager!.requestAlwaysAuthorization()
            locationManager!.distanceFilter = 50 // Don't send location updates with a distance smaller than 50 meters between them
            locationManager!.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // begin location functions
    private func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.locationsMapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func plotRetailers(locations: List<Location>){
        for location in locations {
            let locationLatitude = location["latitude"] as! Double
            let locationLongitude = location["longitude"] as! Double
            let locationTitle = selectedRetailer["name"] as! String
            
            let annotaiton = LocationAnnotation(title: locationTitle, subtitle: "woot", coordinate: CLLocationCoordinate2D(latitude: locationLatitude, longitude: locationLongitude))
            locationsMapView.addAnnotation(annotaiton)
            
        }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
        {
            if annotation.isKind(of: MKUserLocation.self)
            {
                return nil
            }
            
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationIdentifier")
            
            if view == nil
            {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
            }
            
            view?.canShowCallout = true
            
            return view
        }
    }

}
