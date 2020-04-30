//
//  SummaryResponse.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

struct SummaryResponse: Decodable {
    let Global: Global
    let Countries: [Country]
}
