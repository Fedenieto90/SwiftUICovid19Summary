//
//  CountryDetailView.swift
//  Covid19
//
//  Created by Federico Nieto on 20/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    
    var country: CountryViewModel
    @ObservedObject var countryDetailVM = CountryDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MapView(coordinate: countryDetailVM.cases.first?.coordinate ?? CLLocationCoordinate2DMake(0, 0), covidCases: countryDetailVM.casesAnnotations())
                    .frame(height: 400)
                    .padding([.top], 10)
                Text(country.countryCode.flagEmoji()+" Stats")
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding([.leading, .top], 20)
                BarView(country: country)
                Spacer()
            }.onAppear() {
                self.countryDetailVM.fetchCountryCases(country: self.country.countryName)
            }
        }
        
    }
    
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: CountryViewModel(country: Country(Country: "Argentina", CountryCode: "AR", Slug: "Argentina", NewConfirmed: 2000, TotalConfirmed: 2000, NewDeaths: 2000, TotalDeaths: 1000, NewRecovered: 2220, TotalRecovered: 200)))
    }
}

struct BarView: View {
    @State var showGraph: Bool = false
    var country: CountryViewModel
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("\(country.totalConfirmed)")
                    .fontWeight(.bold)
                Rectangle()
                    .frame(width: 80, height: self.showGraph ? convertToHeightValue(value: country.totalConfirmed) : 0)
                    .cornerRadius(16)
                    .foregroundColor(.blue)
                Text("Confirmed")
                    .fontWeight(.bold)
            }.shadow(radius: 10)
            Spacer()
            VStack {
                Text("\(country.totalRecovered)")
                    .fontWeight(.bold)
                Rectangle()
                    .frame(width: 80, height: self.showGraph ? convertToHeightValue(value: country.totalRecovered) : 0)
                    .cornerRadius(16)
                    .foregroundColor(.green)
                Text("Recovered")
                    .fontWeight(.bold)
            }.shadow(radius: 10)
            Spacer()
            VStack {
                Text("\(country.totalDeaths)")
                    .fontWeight(.bold)
                Rectangle()
                    .frame(width: 80, height: self.showGraph ? convertToHeightValue(value: country.totalDeaths) : 0)
                    .cornerRadius(16)
                    .foregroundColor(.red)
                Text("Deaths")
                    .fontWeight(.bold)
            }.shadow(radius: 10)
        }.padding([.leading, .trailing, .top], 20)
            .navigationBarTitle(country.countryName)
            .onAppear() {
                self.animateGraph()
            }
    }
    
    func convertToHeightValue(value: Int) -> CGFloat {
        var rate = 0.1
        if country.totalConfirmed > 100000 {
            rate = 0.001
        } else if country.totalConfirmed > 10000 {
            rate = 0.01
        } else if country.totalConfirmed > 1000 {
            rate = 0.1
        }
        let height = CGFloat(value) * CGFloat(rate)
        if height < 400 {
            return CGFloat(value) * CGFloat(rate)
        } else {
            return CGFloat(400)
        }
    }
    
    // Add Graph Animation
       
       private func animateGraph() {
           if !self.showGraph {
               let animation = Animation.easeInOut(duration: 0.5).delay(0.4)
               withAnimation(animation) {
                   self.showGraph.toggle()
               }
           }
           
       }
}
