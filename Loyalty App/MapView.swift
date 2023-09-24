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

func openMaps() {
    UIApplication.shared.open(NSURL(string: "https://maps.apple.com/?address=Playhouse Square, Quarry Hill, Leeds, LS2 7UP, England")! as URL)
}

struct MapView: View {
    @Environment(\.dismiss) var dismissView
    
    private let location = Location(name: "SwiftLeeds @ Leeds Playhouse", coordinate: CLLocationCoordinate2D(latitude: 53.798076204512014, longitude: -1.5343554195801683))
    
    private let camera: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 53.798076204512014, longitude: -1.5343554195801683),
            distance: 1500,
            heading: 0,
            pitch: 30
        )
    )
    
    var body: some View {
        NavigationStack{
            VStack{
                Map(initialPosition: camera){
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
                        }   // set location annotation
                    
                    UserAnnotation()    //  User location Annotation
                }
                .mapStyle(.standard(elevation: .realistic))
                
                .background(.ultraThinMaterial)
                .safeAreaInset(edge: .bottom) {
                    Spacer()
                    Button{
                        // links to map with direction from current pos to location
                        openMaps()
                    } label: {
                        Text("Take me there")
                            .fontDesign(.serif)
                            .foregroundStyle(.backgroundColour)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .mapControls {
                    MapCompass()
                    MapScaleView()
                    MapUserLocationButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismissView()
                    } label: {
                            Text("Back")
                        .foregroundColor(.white)
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}


#Preview {
    MapView()
}
