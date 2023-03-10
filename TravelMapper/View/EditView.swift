//
//  EditView.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//

import SwiftUI

struct EditView: View {
    
       @Environment(\.dismiss) var dismiss
       var location: Location
       var onSave: (Location) -> Void
       @State private var name: String
       @State private var description: String
       @State private var pages = [Page]()

    var body: some View {
        NavigationView {
                  Form {
                      Section {
                          TextField("Place name", text: $name)
                          TextField("Description", text: $description)
                      }
                      Section{
                          Text("Nearby Places:")
                          ForEach(pages, id: \.pageid) { page in
                                      Text(page.title)
                                          .font(.headline)
                        }
                      }
                  }
                  .navigationTitle("Place details")
                  .toolbar {
                      Button("Save") {
                          var newLocation = location
                              newLocation.id = UUID()
                              newLocation.name = name
                              newLocation.description = description

                              onSave(newLocation)
                          dismiss()
                }
            }
        }.task{
            await getData()
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func getData() async{
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("error while loading url")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Results.self, from: data)
            pages = items.query.pages.values.sorted { $0.title < $1.title }
        } catch{
            print("error")
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){_ in}
    }
}
