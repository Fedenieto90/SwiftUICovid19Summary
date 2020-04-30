//
//  ContentView.swift
//  Covid19
//
//  Created by Federico Nieto on 17/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private struct Constants {
        static let title = "Covid-19"
    }
    
    var body: some View {
        NavigationView {
            CountryListView()
                .navigationBarTitle(Constants.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
