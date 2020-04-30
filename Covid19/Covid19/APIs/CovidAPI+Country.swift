//
//  CovidAPI+Country.swift
//  Covid19
//
//  Created by Federico Nieto on 20/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

extension CovidAPI {
    
    func getCases(by countryName: String, completion: @escaping ([Case]?) -> ()) {
        
        guard let encodedCountry = countryName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(nil)
            return
        }
        
        guard let url = URL(string: Constants.baseUrl+"dayone/country/\(encodedCountry)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let caseData = try? JSONDecoder().decode([Case].self, from: data)
            
            if let caseData = caseData {
                DispatchQueue.main.async {
                    completion(caseData)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
}
