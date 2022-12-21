//
//  ContentView.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//

import SwiftUI

struct ContentView: View {
   @State var location: Location
    var body: some View {
        
        TabView {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            LocationsListView(location: location)
                .tabItem {
                    Label("Locations", systemImage: "mappin")
            }
        }.accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(location: Location.example)
    }
}
