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

func openMapsApp(to destination: Location) {
    let placemark = MKPlacemark(coordinate: destination.coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = destination.name
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
    
    mapItem.openInMaps(launchOptions: launchOptions)
}

struct MapView: View {
    @Environment(\.dismiss) var dismissView
    
    private let location = Location(
        name: "SwiftLeeds @ Leeds Playhouse",
        coordinate: CLLocationCoordinate2D(latitude: 53.798076204512014, longitude: -1.5343554195801683)
    )

    
    var body: some View {
        NavigationStack{
            VStack{
                mapViewController(location: location)
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

struct mapViewController: View {
    let location: Location
    
    private let camera: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 53.798076204512014, longitude: -1.5343554195801683),
            distance: 1500,
            heading: 0,
            pitch: 30
        )
    )
    
    var body: some View {
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
                }
            
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
        .background(.ultraThinMaterial)
        .mapControls {
            MapCompass()
            MapScaleView()
            MapUserLocationButton()
            MapPitchToggle()
        }
        .tint(.backgroundColour)
        
        .safeAreaInset(edge: .bottom) {
            Button{
                openMapsApp(to: location)
            } label: {
                    Text("Take me there")
                        .fontDesign(.serif)
                        .foregroundStyle(.specialColour)
                        .backgroundStyle(.ultraThinMaterial)
            }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 20)
                .controlSize(.large)
        }
    }
}

#Preview {
    MapView()
}
