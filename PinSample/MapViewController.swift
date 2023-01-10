//
//  MapViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/08.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addNavBarItem: UIBarButtonItem!
    @IBOutlet weak var refreshNavBarItem: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Properties
    private var mapAnnotations = [MKPointAnnotation]()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setupAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Helper Methods
    private func setupAnnotations() {
        for location in AppData.studentLocations {
            mapAnnotations.append(location.toMKPointAnnotation())
        }
        mapView.addAnnotations(mapAnnotations)
    }
    
    private func clearAllAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        AppData.studentLocations.removeAll()
    }
    
    private func onDataRefresh(inProgress: Bool) {
        refreshNavBarItem.isEnabled = !inProgress
        addNavBarItem.isEnabled = !inProgress
        
        if inProgress {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: Button Actions
    @IBAction func logout(_ sender: UIBarButtonItem) {
        OnTheMapClient.logout { (success, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onRefresh(_ sender: UIBarButtonItem) {
        onDataRefresh(inProgress: true)
        OnTheMapClient.getStudentLocations { (success, error) in
            self.onDataRefresh(inProgress: false)
            if success {
                self.clearAllAnnotations()
                self.setupAnnotations()
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to refresh")
            }
        }
    }
    
    @IBAction func onAddLocation(_ sender: UIBarButtonItem) {
    }
    
}
