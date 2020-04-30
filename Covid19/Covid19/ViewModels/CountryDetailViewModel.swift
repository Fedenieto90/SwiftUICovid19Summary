//
//  CountryDetailViewModel.swift
//  Covid19
//
//  Created by Federico Nieto on 20/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation
import MapKit

class CountryDetailViewModel: ObservableObject {
    
    @Published var cases = [CaseViewModel]()
    
    var webService: CovidAPI
    
    init() {
        webService = CovidAPI()
    }
    
    func fetchCountryCases(country: String) {
        webService.getCases(by: country) { cases in
            if let cases = cases {
                self.cases = cases.map(CaseViewModel.init)
            }
        }
    }
    
    func casesAnnotations() -> [CaseAnnotation] {
        var annotations = [CaseAnnotation]()
        for covidCase in cases {
            annotations.append(covidCase.annotation)
        }
        return annotations
    }
    
}

struct CaseViewModel {
    
    private var covidCase: Case
    let id = UUID()
    
    init(covidCase: Case) {
        self.covidCase = covidCase
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(Double(covidCase.Lat)!, Double(covidCase.Lon)!)
    }
    
    var annotation: CaseAnnotation {
        return CaseAnnotation(title: covidCase.Country, subtitle: covidCase.CountryCode, coordinate: coordinate)
    }
    
    var countryName: String {
        return covidCase.Country
    }
}
