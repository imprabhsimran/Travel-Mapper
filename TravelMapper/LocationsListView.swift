//
//  LocationsListView.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 20/10/22.
//

import SwiftUI

struct LocationsListView: View {
    @StateObject private var viewmodel = ViewModel()
    @State var location: Location
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<viewmodel.locations.count){ _ in
                    Text("\(location.name)")
                }
            }.navigationTitle("Locations")
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView(location: Location.example)
    }
}
