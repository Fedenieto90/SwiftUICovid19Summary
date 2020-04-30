//
//  CovidAPI+Summary.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

extension CovidAPI {
    
    func getSummary(completion: @escaping (SummaryResponse?) -> ()) {
        
        guard let url = URL(string: Constants.baseUrl+"/summary") else {
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
            
            let summaryData = try? JSONDecoder().decode(SummaryResponse.self, from: data)
            
            if let summaryData = summaryData {
                DispatchQueue.main.async {
                    completion(summaryData)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
}
