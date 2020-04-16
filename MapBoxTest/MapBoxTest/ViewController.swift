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
import MapboxGeocoder

class ViewController: UIViewController, UITextFieldDelegate {

    var mapView: NavigationMapView!
    var directionsRoute: Route?
    var textField: UITextField!
    var resultsLabel: UILabel!
    var geocoder: Geocoder!
    var geocodingDataTask: URLSessionDataTask?
    var tableView: UITableView = UITableView()
    var cellCount:Int = 0
    var addresses:[GeocodedPlacemark] = []
    
    // MARK: - Variables
    var annotation:MGLPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupTextField()
        setupTableView()
        geocoder = Geocoder.shared
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.frame = CGRect(x: 10, y: 10, width: 350, height: tableView.contentSize.height)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 44
        mapView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 350),
            tableView.heightAnchor.constraint(equalToConstant: 150)
        ]
        NSLayoutConstraint.activate(constraints)
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
    
    func setupTextField(){
        // TextField Setup
        textField =  UITextField(frame: CGRect(x: 20, y: 100, width: 350, height: 40))
        mapView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            textField.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: mapView.topAnchor, constant: 80 ),
            textField.widthAnchor.constraint(equalToConstant: 350),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        textField.placeholder = "Enter text here"
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
        for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 4 {
            let options = ForwardGeocodeOptions(query: text)
            // To refine the search, you can set various properties on the options object.
            options.focalLocation = CLLocation(latitude: (mapView.userLocation?.coordinate.latitude)!, longitude: (mapView.userLocation?.coordinate.longitude)!)
            options.allowedScopes = [.address, .pointOfInterest]
        
        
        geocodingDataTask = geocoder.geocode(options) {
            (placemarks, attribution, error) in
            guard let placemark = placemarks else {
                return
            }
            self.addresses = placemark
            self.cellCount = placemark.count
            self.tableView.reloadData()
//            let coordinate = placemark.location?.coordinate
//            print("\(coordinate?.latitude), \(coordinate?.longitude)")
//                // 45.270093, -66.050985
        }
        }
    }
    
    @objc func didLongPress(_ sender: UILongPressGestureRecognizer){
        guard sender.state == .began else { return }
        let point = sender.location(in: mapView)
        if annotation != nil{
            mapView.removeAnnotations(mapView.annotations!)
        }
        createAnnotation(point)
    }
    
    func createAnnotation(_ point: CGPoint){
       // Convert point to map coordinates
        
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
