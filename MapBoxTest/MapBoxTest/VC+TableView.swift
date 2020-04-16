//
//  VC+TableView.swift
//  MapBoxTest
//
//  Created by Simone Tissi on 16/04/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = addresses[indexPath.row].qualifiedName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if annotation != nil{
            mapView.removeAnnotations(mapView.annotations!)
        }
        let coordinate = addresses[indexPath.row].location?.coordinate

        textField.text = addresses[indexPath.row].name
        let point = mapView.convert(coordinate!, toPointTo: mapView)
        createAnnotation(point)
        mapView.setCenter(coordinate!, zoomLevel: 14, animated: true)
    }
}
