//
//  CaseAnnotation.swift
//  Covid19
//
//  Created by Federico Nieto on 21/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation
import MapKit

class CaseAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
