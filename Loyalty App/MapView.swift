//
//  MapView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 22/09/2023.
//

import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @Environment(\.dismiss) var dismissView
    
    private let location = Location(name: "SwiftLeeds @ Leeds Playhouse", coordinate: CLLocationCoordinate2D(latitude: 53.798076204512014, longitude: -1.5343554195801683))
   // @State private var region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 53.79832411792161, longitude: -1.5351021786619503), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    private let region: MapCameraPosition = .automatic

    
    var body: some View {
        VStack{
            
            Map{
                Annotation(
                    location.name,
                    coordinate: location.coordinate,
                    anchor: .bottom) {
                        HStack{
                            Image(systemName: "person.3.sequence")
                                .foregroundStyle(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "mappin")
                                .foregroundStyle(.red)
                        }
                        .padding(2)
                    }
            }
            .mapStyle(.standard(elevation: .realistic))

                .background(.backgroundColour)
                .safeAreaInset(edge: .bottom) {
                    Spacer()
                    Button{
                        // links to map with direction from current pos to location
                    } label: {
                        Text("Take me there")
                            .fontDesign(.serif)
                            .foregroundStyle(.backgroundColour)
                    }
                    .buttonStyle(.borderedProminent)
                }
           
        }
        .toolbar{
            ToolbarItem (placement: .topBarLeading){
                Button("Back"){
                    dismissView()
                }
            }
        }
    }
}


#Preview {
    MapView()
}
