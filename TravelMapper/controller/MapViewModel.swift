//
//  MapViewModel.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//

import Foundation
import MapKit

final class ViewModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var selectedPlace: Location?
    @Published private(set) var locations : [Location]
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.62, longitude: 74.8765), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
//    load data when app reopens
    override init() {
        do {
            let data = try Data(contentsOf: savePath)
            locations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            locations = []
        }
    }
//    save the data
    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
//    add new location
    func addLocation() {
        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
        locations.append(newLocation)
        save()
    }
//    edit new location when id is same
    func update(location: Location) {
        guard let selectedPlace = selectedPlace else { return }

        if let index = locations.firstIndex(of: selectedPlace) {
            locations[index] = location
            save()
        }
    }
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabelled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("loation not available")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("parentel control")
        case .denied:
            print("you have denied permission")
        case .authorizedAlways,.authorizedWhenInUse:
            DispatchQueue.main.async {
                self.mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
