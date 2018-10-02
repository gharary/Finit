//
//  MapBoxVC.swift
//  Finit
//
//  Created by Mohammad Gharari on 1/7/18.
//  Copyright © 2018 Mohammad Gharari. All rights reserved.
//

import UIKit
import Mapbox
import MapKit

class MapBoxVC: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate {

    
    //To Manage current location of user
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    var coordinate: CLLocationCoordinate2D? = nil
    var initialLocation: CLLocation? = nil
    
    var mapView: MGLMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setupMap()
        setupMapBox()
        
        
 
    }
    
    func setupMapBox() {
        
        mapView = MGLMapView(frame: view.bounds)
        
        
        // Do any additional setup after loading the view.
        //let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Set the map's center coordinate and zool level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 45.5076, longitude: -122.6736), zoomLevel: 11, animated: false)
        view.addSubview(mapView)
        
        //Set the delegate property of our map view to 'self' after instantiating it.
        mapView.delegate = self
        
        /*
        //Declare the market 'hello' and set its coordinates, title, and subtitle.
        let hello = MGLPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407)
        hello.title = "Hello World!"
        hello.subtitle = "Welcome to my marker"
        
        
        //Add marker 'hello' to the map
        mapView.addAnnotation(hello)
 */
        
    }
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        loadGeoJson()
    }
    
    func loadGeoJson() {
        DispatchQueue.global().async {
            //Get the path for example.geojson in app's bundle.
            guard let jsonUrl = Bundle.main.url(forResource: "example", withExtension: "geojson") else { return }
            guard let jsonData = try? Data(contentsOf: jsonUrl) else { return }
            DispatchQueue.main.async {
                self.drawPolyline(geoJson: jsonData)
            }
        }
    }
    
    func drawPolyline(geoJson: Data) {
        //Add our GeoJSON data to the map as an MGLGeoJSONSource.
        //We can then reference this data from an MGLStyleLayer.
        
        //MGLMapView.style is optional, so you must guard against it not being set.
        guard let style = self.mapView.style else { return }
        
        let shapeFromGeoJSON = try! MGLShape(data: geoJson, encoding: String.Encoding.utf8.rawValue)
        let source = MGLShapeSource(identifier: "polyline", shape: shapeFromGeoJSON, options: nil)
        
        style.addSource(source)
        
        let layer = MGLLineStyleLayer(identifier: "polyline", source: source)
        layer.lineJoin = MGLStyleValue(rawValue: NSValue(mglLineJoin: .round))
        layer.lineCap = MGLStyleValue(rawValue: NSValue(mglLineCap: .round))
        layer.lineColor = MGLStyleValue(rawValue: UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1))
        //Use a style function to smoothly adjust the line width from 2pt to 20pt between zoom levels 14 and 18. the 'interpolationBase' parameter allows the values to interpolate along an exponential curve.
        layer.lineWidth = MGLStyleValue(interpolationMode: .exponential, cameraStops: [14: MGLStyleValue<NSNumber>(rawValue: 2), 18: MGLStyleValue<NSNumber>(rawValue: 20)], options: [.defaultValue: MGLConstantStyleValue<NSNumber>(rawValue: 1.5)])
        
        //We can also add a second layer that will draw a stroke around the original line.
        let casingLayer = MGLLineStyleLayer(identifier: "polyline-case", source: source)
        //Copy these attributes from the main line layer.
        casingLayer.lineJoin = layer.lineJoin
        casingLayer.lineCap = layer.lineCap
        //Line gap width represents the space before the outline begins, so sould match the main line's line width exactly.
        casingLayer.lineGapWidth = layer.lineWidth
        //stroke color slightly darker than the line color.
        casingLayer.lineColor = MGLStyleValue(rawValue: UIColor(red: 41/255, green: 145/255, blue: 171/255, alpha: 1))
        //Use a style function to gradually increase the stroke width between zoom levels 14 and 18.
        casingLayer.lineWidth = MGLStyleValue(interpolationMode: .exponential, cameraStops: [14: MGLStyleValue(rawValue: 1), 18:MGLStyleValue(rawValue: 4)], options: [.defaultValue: MGLConstantStyleValue<NSNumber>(rawValue: 1.5)])
        
        //Just for fun, let's add another copy of the line with a dash pattern
        // Just for fun, let’s add another copy of the line with a dash pattern.
        let dashedLayer = MGLLineStyleLayer(identifier: "polyline-dash", source: source)
        dashedLayer.lineJoin = layer.lineJoin
        dashedLayer.lineCap = layer.lineCap
        dashedLayer.lineColor = MGLStyleValue(rawValue: .white)
        dashedLayer.lineOpacity = MGLStyleValue(rawValue: 0.5)
        dashedLayer.lineWidth = layer.lineWidth
        // Dash pattern in the format [dash, gap, dash, gap, ...]. You’ll want to adjust these values based on the line cap style.
        dashedLayer.lineDashPattern = MGLStyleValue(rawValue: [0, 1.5])
        
        style.addLayer(layer)
        style.addLayer(dashedLayer)
        style.insertLayer(casingLayer, below: layer)
        
    }
    func setupMap() {
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        self.coordinate = locValue
        self.initialLocation = CLLocation(latitude: CLLocationDegrees((manager.location?.coordinate.latitude)!), longitude: CLLocationDegrees((manager.location?.coordinate.longitude)!))
        
        
        //self.centerMapOnLocation(location: initialLocation!)
        
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let artWork =
            //Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            Artwork(title: " دستگاه iPhone شما", locationName: "آدرس محل شما", discipline: "GPS", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        initialLocation? = location
        /*
        UIView.animate(withDuration: 4.5, animations: {
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.addAnnotation(artWork)
        })
        */
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    //Use the default marker. See also: our view annotaion or sutom marker example.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
        
    }
    
    //Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
        
    }

    

}
