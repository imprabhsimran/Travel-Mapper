//
//  WikiData.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 22/10/22.
//

import Foundation

struct Results : Codable{
    let query : Query
}

struct Query: Codable{
    let pages:[Int: Page]
}

struct Page: Codable{
    let pageid: Int
    let title: String
    let terms:[String:[String]]?
}
