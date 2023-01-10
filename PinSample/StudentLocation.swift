//
//  StudentLocation.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation
import MapKit

struct StudentLocation: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    var objectId: String? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    
    init(address: String, url: String, userId: String, location: CLLocationCoordinate2D) {
        self.firstName = UserSession.firstName
        self.lastName = UserSession.lastName
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.mapString = address
        self.mediaURL = url
        self.uniqueKey = userId
    }
    
    func copy(location: CLLocationCoordinate2D) -> StudentLocation {
        return StudentLocation(address: self.mapString, url: mediaURL, userId: self.uniqueKey, location: location)
    }
}

extension StudentLocation {
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    func toCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toMKPointAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = toCoordinate2D()
        annotation.title = fullName
        annotation.subtitle = mediaURL
        return annotation
    }
}
