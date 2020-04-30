//
//  SummaryViewModel.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

class SummaryViewModel: ObservableObject {
    
    @Published var global: GlobalViewModel?
    @Published var countries = [CountryViewModel]()
    
    var webService: CovidAPI
    
    init() {
        self.webService = CovidAPI()
        self.fetchSummary()
    }
    
    // MARK: - Fetch Covid Summary
    
    func fetchSummary() {
        webService.getSummary { summaryResponse in
            if let summaryResponse = summaryResponse {
                self.global = GlobalViewModel(global: summaryResponse.Global)
                self.countries = summaryResponse.Countries.map(CountryViewModel.init)
                self.sortCountriesByTotalDeaths()
            }
        }
    }
    
    // MARK: - Filter
    
    func filterSummary() {
        let filteredCountries = self.countries.filter { countryViewModel -> Bool in
            countryViewModel.countryCode == "AR"
        }
        self.countries = filteredCountries
    }
    
    func sortCountriesByTotalDeaths() {
        let sortedCountries = self.countries.sorted { (countryViewModel1, countryViewModel2) -> Bool in
            countryViewModel1.totalDeaths > countryViewModel2.totalDeaths
        }
        self.countries = sortedCountries
    }
    
    func countriesToDisplay(searchTerm: String) -> [CountryViewModel] {
        if searchTerm.isEmpty {
            return countries
        }
        return countries.filter({ $0.countryName.contains(searchTerm)})
    }
    
}

struct GlobalViewModel {
    
    let id = UUID()
    private var global: Global
    
    init(global: Global) {
        self.global = global
    }
    
    var newConfirmed: Int {
        return global.NewConfirmed
    }
    
    var totalConfirmed: Int {
        return global.TotalConfirmed
    }
    
    var totalRecovered: Int {
        return global.TotalRecovered
    }
    
    var totalDeaths: Int {
        return global.TotalDeaths
    }
}

struct CountryViewModel {
    
    let id = UUID()
    private var country : Country
    
    init(country: Country) {
        self.country = country
    }
    
    var newConfirmed: Int {
        return country.NewConfirmed
    }
    
    var totalConfirmed: Int {
        return country.TotalConfirmed
    }
    
    var totalRecovered: Int {
        return country.TotalRecovered
    }
    
    var totalDeaths: Int {
        return country.TotalDeaths
    }
    
    var countryName: String {
        return country.Country
    }
    
    var countryCode: String {
        return country.CountryCode
    }
}
