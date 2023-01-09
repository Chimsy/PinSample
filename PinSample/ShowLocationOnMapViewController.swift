//
//  ShowLocationOnMapViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit
import MapKit

class ShowLocationOnMapViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    //member field to be passed from previous controller
    var studentLocation: StudentLocation!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(studentLocation.toCoordinate2D(), animated: false)
        mapView.addAnnotation(studentLocation.toMKPointAnnotation())
        mapView.delegate = self
    }
    
    // MARK: Helper Methods
    func isLocationSaving(inProgress: Bool) {
        finishButton.isEnabled = !inProgress
        if inProgress {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: Button Actions
    @IBAction func finish(_ sender: UIButton) {
        isLocationSaving(inProgress: true)
        
        OnTheMapClient.postStudentLocation(studentLocation: studentLocation) { (success, error) in
            self.isLocationSaving(inProgress: false)
            if success {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to save location")
            }
        }
        
    }
    
    
}

extension ShowLocationOnMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "PinView"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
            pinView!.tintColor = .red
            pinView!.isDraggable = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let url = URL(string: view.annotation!.subtitle!!) {
            openUrl(url: url)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        self.studentLocation = self.studentLocation.copy(location: view.annotation!.coordinate)
    }
}
