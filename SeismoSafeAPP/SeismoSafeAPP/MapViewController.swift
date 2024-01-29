//
//  ViewController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 14.01.24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let viewModel  = EartquakeViewModel()
    var allAnnotations: [MKAnnotation] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchData()
    }
    
    func fetchData(){
        viewModel.getLast1HourEarthquakes()
            self.displayEarthquakeOnMap()
    }
    func displayEarthquakeOnMap() {
        mapView.removeAnnotations(allAnnotations)
        
        let limitedEarthquakes = Array(viewModel.eartquakes.prefix(10))
        for earthquake in limitedEarthquakes {
            guard let coordinates = earthquake.geometry?.coordinates,
                  coordinates.count >= 2 else {
                continue
            }

            let coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
            
            if let earthquakeFeature = earthquake as? EarthquakeFeature {
                let annotation = EarthquakeAnnotation(coordinate: coordinate, earthquakeFeature: earthquakeFeature)
                mapView.addAnnotation(annotation)
                allAnnotations.append(annotation)
            } else {
                print("Error: Cannot convert EarthquakeFeature to Earthquake")
            }
        }
        
        mapView.showAnnotations(allAnnotations, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let earthquakeAnnotation = annotation as? EarthquakeAnnotation else {
            return nil
        }

        let identifier = "earthquakePin"
        var annotationView: MKAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        if earthquakeAnnotation.earthquakeFeature.properties?.mag ?? 0 > 1.0 {
            annotationView.image = UIImage(named: "alarm_icon")
            startBlinking(for: annotationView)
        } else {
            annotationView.image = UIImage(named: "alarm_icon 2")
            stopBlinking(for: annotationView)
        }

        return annotationView
    }
    
       func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
           
           fetchData()
       }
       func startBlinking(for annotationView: MKAnnotationView) {
           let animation = CABasicAnimation(keyPath: "opacity")
           animation.fromValue = 1
           animation.toValue = 0
           animation.autoreverses = true
           animation.duration = 0.5
           animation.repeatCount = Float.infinity
           annotationView.layer.add(animation, forKey: "blinking")
       }
       func stopBlinking(for annotationView: MKAnnotationView) {
           annotationView.layer.removeAnimation(forKey: "blinking")
       }
   }

        
        
    


