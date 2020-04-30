//
//  Country.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

struct Country: Decodable {
    
    let id = UUID()
    
    let Country: String
    let CountryCode: String
    let Slug: String
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
    
}
