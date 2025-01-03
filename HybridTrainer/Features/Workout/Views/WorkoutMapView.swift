import SwiftUI
import MapKit

struct WorkoutMapView: View {
    let route: [LocationSample]
    @State private var region: MKCoordinateRegion
    @State private var showingFullScreen = false
    @State private var selectedPoint: LocationSample?
    
    init(route: [LocationSample]) {
        self.route = route
        
        // Initialize map region with the first coordinate
        let initialCoordinate = route.first?.coordinate ?? CLLocationCoordinate2D()
        _region = State(initialValue: MKCoordinateRegion(
            center: initialCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: false) {
                // Route line
                MapPolyline(coordinates: route.map { $0.coordinate })
                    .stroke(Theme.accent, lineWidth: 3)
                
                // Interactive markers
                ForEach(route, id: \.timestamp) { point in
                    Marker("", coordinate: point.coordinate)
                        .tint(markerColor(for: point))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Button(action: { showingFullScreen = true }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(8),
                alignment: .topTrailing
            )
        }
        .sheet(isPresented: $showingFullScreen) {
            NavigationView {
                fullScreenMap
                    .navigationTitle("Workout Route")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                showingFullScreen = false
                            }
                        }
                    }
            }
        }
    }
    
    private var fullScreenMap: some View {
        Map(coordinateRegion: $region, showsUserLocation: false) {
            MapPolyline(coordinates: route.map { $0.coordinate })
                .stroke(Theme.accent, lineWidth: 3)
            
            ForEach(route, id: \.timestamp) { point in
                Marker("", coordinate: point.coordinate)
                    .tint(markerColor(for: point))
            }
        }
        .overlay(
            routeInfoPanel
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(),
            alignment: .bottom
        )
    }
    
    private func markerColor(for point: LocationSample) -> Color {
        if point == route.first { return .green }
        if point == route.last { return .red }
        return Theme.accent
    }
} 