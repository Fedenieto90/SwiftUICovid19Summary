//
//  CountryListView.swift
//  Covid19
//
//  Created by Federico Nieto on 18/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    
    // MARK: - View Model
    
    @ObservedObject var summaryVM: SummaryViewModel
    
    // MARK: - Cycle
    
    init() {
        UITableView.appearance().separatorStyle = .none
        self.summaryVM = SummaryViewModel()
    }
    
    // MARK: - State
    
    @State var searchTerm: String = ""
    
    var body: some View {
        List {
            Section(header: GlobalSummaryView(global: summaryVM.global, searchTerm: $searchTerm)
                .padding().frame(width: UIScreen.main.bounds.width)) {
                ForEach(summaryVM.countriesToDisplay(searchTerm: self.searchTerm), id: \.id) { country in
                    NavigationLink(destination: CountryDetailView(country: country)) {
                        CountryCell(country: country)
                            .padding([.top, .bottom], 10)
                    }
                }
            }
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}

struct CountryCell: View {
    var country: CountryViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(country.countryCode.flagEmoji()+" "+country.countryName)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Confirmed: \(country.totalConfirmed)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(16)
                        .shadow(radius: 16)
                    Spacer()
                    Text("Recovered: \(country.totalRecovered)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(16)
                        .shadow(radius: 16)
                }
                Spacer()
                Text("Deaths: \(country.totalDeaths)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(16)
                    .shadow(radius: 16)
            }
        }
    }
}
