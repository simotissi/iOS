/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import MapKit

class ViewController: UIViewController {

  let regionRadius: CLLocationDistance = 1000
  var artworks: [Artwork] = []
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set initial location to Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    centerMapOnLocation(location: initialLocation)
    
    // set ViewController as the delegate of the map view
    mapView.delegate = self
    
//    // show artwork on map
//    let artwork = Artwork(title: "King David Kalakaua",
//      locationName: "Waikiki Gateway Park",
//      discipline: "Sculpture",
//      coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//    mapView.addAnnotation(artwork)
    mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    loadInitialData()
    mapView.addAnnotations(artworks)
  }
  
  // location is the center, with a radius of regionRadius (1000m)
  func centerMapOnLocation(location: CLLocation){
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
    //this tells mapView to display the region
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func loadInitialData() {
    // 1
    guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
      else { return }
    let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

    guard
      let data = optionalData,
      // 2
      let json = try? JSONSerialization.jsonObject(with: data),
      // 3
      let dictionary = json as? [String: Any],
      // 4
      let works = dictionary["data"] as? [[Any]]
      else { return }
    // 5
    let validWorks = works.flatMap { Artwork(json: $0) }
    artworks.append(contentsOf: validWorks)
  }

}

// MARK: - MKMapViewDelegate -
extension ViewController: MKMapViewDelegate {
  // 1 - this method gets caled for every annotation
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    // 2 - check that this annotation is an Artwork
//    guard let annotation = annotation as? Artwork else { return nil }
//    // 3 - create a MKMarkerAnnotationView object to see the marker
//    let identifier = "marker"
//    var view: MKMarkerAnnotationView
//    // 4 - like table view, a map view reuses annotation views that are no longer visible
//    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//      as? MKMarkerAnnotationView {
//      dequeuedView.annotation = annotation
//      view = dequeuedView
//    } else {
//      // 5 - if there aren't reusable marker, I create a new one
//      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//      view.canShowCallout = true
//      view.calloutOffset = CGPoint(x: -5, y: 5)
//      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//    }
//    return view
//  }
  
  // called when the user tap the info button
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! Artwork
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMaps(launchOptions: launchOptions)
  }

}
