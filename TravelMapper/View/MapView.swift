//
//  MapView.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 40)
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        Text("\(location.name)")
                            .fixedSize()
                    }
                }
            }
            .onAppear(perform: viewModel.checkIfLocationServicesIsEnabelled)
            .ignoresSafeArea()
            Circle()
                .fill(.red)
                .opacity(0.4)
                .frame(width: 30, height: 30)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        viewModel.addLocation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding()
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place){ newlocation in
                    viewModel.update(location: newlocation)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
