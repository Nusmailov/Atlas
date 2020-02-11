//
//  MapClass.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 11/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class MapClass : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String,location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
