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

        let latitude:CLLocationDegrees = studentLocation.latitude
        let longitude:CLLocationDegrees = studentLocation.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: false)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.setCenter(studentLocation.toCoordinate2D(), animated: false)
        mapView.addAnnotation(studentLocation.toMKPointAnnotation())
        mapView.delegate = self
    }
    
    // MARK: Helper Methods
    func isLocationSaving(inProgress: Bool) {
        finishButton.isEnabled = !inProgress
        
        inProgress ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
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
