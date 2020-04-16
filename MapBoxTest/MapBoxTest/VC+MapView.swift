//
//  VC+MapView.swift
//  MapBoxTest
//
//  Created by Simone Tissi on 15/04/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import Foundation
import Mapbox
import MapboxNavigation
import MapboxGeocoder


extension ViewController: MGLMapViewDelegate{
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        let navigationViewController = NavigationViewController(for: directionsRoute!)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        geocodingDataTask?.cancel()
    }
}
