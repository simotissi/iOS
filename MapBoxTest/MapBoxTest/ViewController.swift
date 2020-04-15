//
//  ViewController.swift
//  MapBoxTest
//
//  Created by Simone Tissi on 15/04/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

class ViewController: UIViewController {
    var mapView: NavigationMapView!
    var directionsRoute: Route?
    
    // MARK: - Variables
    var annotation:MGLPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    func setupMap(){
        
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
        mapView.delegate = self
        
        //Adding gesture recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        mapView.addGestureRecognizer(longPress)
    }
    
    @objc func didLongPress(_ sender: UILongPressGestureRecognizer){
        guard sender.state == .began else { return }
        if annotation != nil{
            mapView.removeAnnotations(mapView.annotations!)
        }
        
        // Convert point to map coordinates
        let point = sender.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        annotation = MGLPointAnnotation()
        annotation!.coordinate = coordinate
        annotation!.title = "Start navigation"
        
        calculateRoute(from: mapView.userLocation!.coordinate, to: annotation!.coordinate) { (route, error) in
            if error != nil{
                print("Error calculating route")
            }
            
        }
        // Create point annotation and add in the map
        mapView.addAnnotation(annotation!)
    }
    
    func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(Route?, Error?) -> ()){
        
        // Coordinate accuracy is the maximum distance away from the waypoint that the route may still be considered viable, measured in meters. Negative values indicate that a indefinite number of meters away from the route and still be considered viable.
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Finish")
        
        // Specify that the route is intended for automobiles avoiding traffic
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        
        // Generate the route object and draw it on the map
        _ = Directions.shared.calculate(options) { [unowned self] (waypoints, routes, error) in
            self.directionsRoute = routes?.first
            self.drawRoute(route: self.directionsRoute!)
        }
        // Draw the route on the map after creating it
    }
    
    func drawRoute(route: Route){
        guard route.coordinateCount > 0 else { return }
        
        //Convert route to polyline
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
        
        // reset the shape if there is another route line in map
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource{
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            
            // setup route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-source", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)
            
            // add the source and style layer of the route line to the map
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
    }
}
