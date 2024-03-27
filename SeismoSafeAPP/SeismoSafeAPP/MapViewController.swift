//
//  ViewController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 14.01.24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var magnitudeSegmentControl: UISegmentedControl!
    
    let viewModel = EartquakeViewModel()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           mapView.delegate = self
           magnitudeSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
           fetchData()
       }
       func fetchData() {
           viewModel.getLast1HourEarthquakes()
           viewModel.success = { [self] in
               self.displayEarthquakeOnMap(forMagnitudeSegment: magnitudeSegmentControl.selectedSegmentIndex)
           }
       }
       @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
           displayEarthquakeOnMap(forMagnitudeSegment: sender.selectedSegmentIndex)
       }
       func displayEarthquakeOnMap(forMagnitudeSegment segmentIndex: Int) {
           mapView.removeAnnotations(viewModel.allAnnotations)
           
           let filteredEarthquakes = viewModel.filterEarthquakes(byMagnitudeSegment: segmentIndex)
           
           let limitedEarthquakes = Array(filteredEarthquakes.prefix(10))
           
           for earthquake in limitedEarthquakes {
               guard let coordinates = earthquake.geometry?.coordinates,
                     coordinates.count >= 2 else {
                   continue
               }
               let coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
               let annotation = EarthquakeAnnotation(coordinate: coordinate, earthquakeFeature: earthquake)
               mapView.addAnnotation(annotation)
               viewModel.allAnnotations.append(annotation)
           }
           
           mapView.showAnnotations(viewModel.allAnnotations, animated: true)
       }
       
   }
//MARK Extension
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation {
                let popupViewController = UIAlertController(title: annotation.title ?? "", message: annotation.subtitle ?? "", preferredStyle: .alert)
                popupViewController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                present(popupViewController, animated: true, completion: nil)
            } else {
                print("Alinmadi")
            }
        }
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
 func showBottomSheet(for annotation: EarthquakeAnnotation) {
     let boottomSheetViewController = BottomSheetViewController()
     
     present(boottomSheetViewController, animated: true, completion: nil)
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
            startBlinking(for: annotationView)
        } else {
            stopBlinking(for: annotationView)
        }
        annotationView.image = UIImage(named: "alarm_icon 2")
        return annotationView
    }
}
