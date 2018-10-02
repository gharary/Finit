//
//  MainVC.swift
//  Finit
//
//  Created by Mohammad Gharari on 1/2/18.
//  Copyright © 2018 Mohammad Gharari. All rights reserved.
//

import UIKit
import MapKit


class MainVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //to manage current location of user
    let locationManager =  CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    var coordinate : CLLocationCoordinate2D? = nil
    var initialLocation: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupMap()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        self.coordinate = locValue
        self.initialLocation = CLLocation(latitude: CLLocationDegrees((manager.location?.coordinate.latitude)!), longitude: CLLocationDegrees((manager.location?.coordinate.longitude)!))
        
        
        self.centerMapOnLocation(location: initialLocation!)
        
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let artWork =
            //Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            Artwork(title: " دستگاه iPhone شما", locationName: "آدرس محل شما", discipline: "GPS", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        UIView.animate(withDuration: 4.5, animations: {
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.addAnnotation(artWork)
        })
        
        locationManager.stopUpdatingLocation()
        
    }
    func setupMap() {
        //Ask for Authorisation from the User
        self.locationManager.requestAlwaysAuthorization()
        
        //For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        //centerMapOnLocation(location: initialLocation!)
        
        //mapView.setRegion(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>, animated: <#T##Bool#>)
    }

    

    //NSLocationAlwaysAndWhenInUseUsageDescription and NSLocationWhenInUseUsageDescription 
}
