//
//  Place.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//

import Foundation
import CoreLocation

struct Location: Identifiable,Codable,Equatable{
     var id: UUID
     var name: String
     var description: String
     let latitude: Double
     let longitude: Double
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
   static var example = Location(id: UUID(), name: "", description: "", latitude: 51.501, longitude: -0.141)
    
    
}
