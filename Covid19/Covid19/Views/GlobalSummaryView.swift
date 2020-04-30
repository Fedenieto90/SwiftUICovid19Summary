//
//  GlobalSummaryView.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import SwiftUI

struct GlobalSummaryView: View {
    
    var global: GlobalViewModel?
    
    @Binding var searchTerm: String
    @State var animateGlobe: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchView(searchTerm: self.$searchTerm)
            HStack {
                Text("Global")
                    .font(.custom("Arial", size: 50))
                    .fontWeight(.bold)
                Spacer()
                Text("🌎")
                    .font(.custom("Arial", size: 50))
                    .fontWeight(.bold)
                    .rotationEffect(.degrees(animateGlobe ? 360.0 : 0.0))
                    .animation(Animation.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 7.0, initialVelocity: 0.0).delay(0.5))
                    .shadow(radius: 10)
            }
            
            Text("Summary")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            HStack {
                Text("Total Confirmed \(global?.totalConfirmed ?? 0)")
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(16)
                    .shadow(radius: 16)
                
                Spacer()
                Text("Total Recovered \(global?.totalRecovered ?? 0)")
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(16)
                    .shadow(radius: 16)
                Spacer()
                Text("Total Deaths \(global?.totalDeaths ?? 0)")
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(16)
                    .shadow(radius: 16)
                
            }.padding([.top], 20)
            Text("Data is sourced from Johns Hopkins CSSE")
                .font(.caption)
                .padding([.top], 20)
                .foregroundColor(.secondary)
        }.onAppear() {
            self.animateGlobe.toggle()
        }
    }
}

struct GlobalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSummaryView(global: GlobalViewModel(global: Global(NewConfirmed: 100, TotalConfirmed: 20, NewDeaths: 10, TotalDeaths: 1, NewRecovered: 22, TotalRecovered: 321)), searchTerm: .constant("")).previewLayout(.sizeThatFits)
    }
}
