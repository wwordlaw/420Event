// import SwiftUI
// import MapKit

// struct Dispensary: Identifiable {
//     let id = UUID()
//     let name: String
//     let address: String
//     let phone: String
//     let hours: [String: String]
//     let url: String
//     var coordinate: CLLocationCoordinate2D?
    
//     var mapItem: MKMapItem? {
//         guard let coordinate = coordinate else { return nil }
//         let placemark = MKPlacemark(coordinate: coordinate)
//         let item = MKMapItem(placemark: placemark)
//         item.name = name
//         return item
//     }
// }

// class DispensaryViewModel: ObservableObject {
//     @Published var dispensaries: [Dispensary] = []
//     @Published var region = MKCoordinateRegion(
//         center: CLLocationCoordinate2D(latitude: 42.36, longitude: -83.10),
//         span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//     )
    
//     private let geocoder = CLGeocoder()
//     private var dispensariesData: [Dispensary] = []
    
//     init() {
//         setupData()
//         geocodeNext(index: 0)
//     }
    
//     private func setupData() {
//         dispensariesData = [
//             Dispensary(
//                 name: "The Clinic Detroit",
//                 address: "13815 M-102, Detroit, MI 48235",
//                 phone: "(313) 539-8666",
//                 hours: [
//                     "Friday": "9 AM–10 PM",
//                     "Saturday": "9 AM–10 PM",
//                     "Sunday": "9 AM–10 PM",
//                     "Monday": "9 AM–10 PM",
//                     "Tuesday": "9 AM–10 PM",
//                     "Wednesday": "9 AM–10 PM",
//                     "Thursday": "9 AM–10 PM"
//                 ],
//                 url: "https://weedmaps.com/dispensaries/the-clinic-detroit"
//             ),
//             Dispensary(
//                 name: "The House of Mary Jane",
//                 address: "19154 James Couzens Fwy, Detroit, MI 48235",
//                 phone: "(313) 340-9202",
//                 hours: [
//                     "Friday": "9 AM–10 PM",
//                     "Saturday": "9 AM–10 PM",
//                     "Sunday": "9 AM–10 PM",
//                     "Monday": "9 AM–10 PM",
//                     "Tuesday": "9 AM–10 PM",
//                     "Wednesday": "9 AM–10 PM",
//                     "Thursday": "9 AM–10 PM"
//                 ],
//                 url: "https://www.leafly.com/dispensary-info/house-of-mary-jane"
//             ),
//             Dispensary(
//                 name: "Plan B Wellness Center",
//                 address: "20101 M-102, Detroit, MI 48219",
//                 phone: "(248) 470-4638",
//                 hours: [
//                     "Friday": "9 AM–10 PM",
//                     "Saturday": "9 AM–10 PM",
//                     "Sunday": "9 AM–10 PM",
//                     "Monday": "9 AM–10 PM",
//                     "Tuesday": "9 AM–10 PM",
//                     "Wednesday": "9 AM–10 PM",
//                     "Thursday": "9 AM–10 PM"
//                 ],
//                 url: "https://weedmaps.com/dispensaries/plan-b-wellness-center-detroit"
//             ),
//             Dispensary(
//                 name: "Shake & Bake",
//                 address: "20477 Schaefer Hwy, Detroit, MI",
//                 phone: "(313) 397-7926",
//                 hours: [
//                     "Friday": "10 AM–9 PM",
//                     "Saturday": "10 AM–9 PM",
//                     "Sunday": "10 AM–8 PM",
//                     "Monday": "10 AM–9 PM",
//                     "Tuesday": "10 AM–9 PM",
//                     "Wednesday": "10 AM–9 PM",
//                     "Thursday": "10 AM–9 PM"
//                 ],
//                 url: "https://www.leafly.com/dispensary-info/s-and-b-resource-center"
//             ),
//             Dispensary(
//                 name: "The Jazz Cannabis Club",
//                 address: "16890 Telegraph Rd, Detroit, MI",
//                 phone: "(313) 636-2582",
//                 hours: [
//                     "Friday": "9 AM–10 PM",
//                     "Saturday": "9 AM–10 PM",
//                     "Sunday": "9 AM–10 PM",
//                     "Monday": "9 AM–10 PM",
//                     "Tuesday": "9 AM–10 PM",
//                     "Wednesday": "9 AM–10 PM",
//                     "Thursday": "9 AM–10 PM"
//                 ],
//                 url: "https://dutchie.com/dispensary/jazz-club-2-detroit"
//             )
//         ]
//     }
    
//     private func geocodeNext(index: Int) {
//         guard index < dispensariesData.count else { return }
//         let dispensary = dispensariesData[index]
//         geocoder.geocodeAddressString(dispensary.address) { [weak self] placemarks, error in
//             guard let self = self else { return }
//             var updatedDispensary = dispensary
//             if let placemark = placemarks?.first, let location = placemark.location {
//                 updatedDispensary.coordinate = location.coordinate
//                 DispatchQueue.main.async {
//                     self.dispensaries.append(updatedDispensary)
//                     if self.dispensaries.count == 1 {
//                         self.region = MKCoordinateRegion(
//                             center: location.coordinate,
//                             span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//                         )
//                     }
//                 }
//             } else {
//                 print("Geocoding error for \(dispensary.name): \(error?.localizedDescription ?? "Unknown error")")
//             }
//             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                 self.geocodeNext(index: index + 1)
//             }
//         }
//     }
    
//     func openInMaps(dispensary: Dispensary) {
//         guard let mapItem = dispensary.mapItem else { return }
//         mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//     }
// }

// struct MapView: View {
//     @ObservedObject var viewModel: DispensaryViewModel
//     @State private var selectedDispensary: Dispensary?
//     @State private var showDetailSheet = false
    
//     var body: some View {
//         Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.dispensaries.filter { $0.coordinate != nil }) { dispensary in
//             MapAnnotation(coordinate: dispensary.coordinate!) {
//                 Button(action: {
//                     selectedDispensary = dispensary
//                     showDetailSheet = true
//                 }) {
//                     VStack {
//                         ZStack {
//                             Circle()
//                                 .fill(Color.sage)
//                                 .frame(width: 44, height: 44)
//                                 .shadow(radius: 3)
//                             Image(systemName: "leaf.fill")
//                                 .foregroundColor(.white)
//                                 .font(.system(size: 22, weight: .bold))
//                         }
//                         Text(dispensary.name)
//                             .font(.caption)
//                             .fontWeight(.bold)
//                             .padding(5)
//                             .background(Color.white.opacity(0.8))
//                             .cornerRadius(8)
//                             .shadow(radius: 2)
//                     }
//                 }
//                 .buttonStyle(PlainButtonStyle())
//             }
//         }
//         .edgesIgnoringSafeArea(.all)
//         .accentColor(.sage)
//         .sheet(isPresented: $showDetailSheet) {
//             if let dispensary = selectedDispensary {
//                 DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
//             }
//         }
//         .overlay(
//             HStack {
//                 Image(systemName: "leaf.fill")
//                     .foregroundColor(.sage)
//                 Text("Detroit Dispensaries")
//                     .font(.headline)
//                     .fontWeight(.bold)
//             }
//             .padding(10)
//             .background(Color.white.opacity(0.9))
//             .cornerRadius(10)
//             .shadow(radius: 3)
//             .padding(.top, 10),
//             alignment: .top
//         )
//     }
// }

// struct DispensaryDetailView: View {
//     let dispensary: Dispensary
//     let viewModel: DispensaryViewModel
//     @Environment(\.presentationMode) var presentationMode
    
//     var body: some View {
//         NavigationView {
//             List {
//                 Section(header: Text("INFORMATION")) {
//                     HStack {
//                         Image(systemName: "building.2.fill")
//                             .foregroundColor(.sage)
//                             .frame(width: 30)
//                         Text(dispensary.name)
//                             .font(.headline)
//                     }
//                     HStack {
//                         Image(systemName: "location.fill")
//                             .foregroundColor(.sage)
//                             .frame(width: 30)
//                         Text(dispensary.address)
//                     }
//                     HStack {
//                         Image(systemName: "phone.fill")
//                             .foregroundColor(.sage)
//                             .frame(width: 30)
//                         Text(dispensary.phone)
//                             .onTapGesture {
//                                 let phone = "tel://" + dispensary.phone
//                                     .replacingOccurrences(of: "(", with: "")
//                                     .replacingOccurrences(of: ")", with: "")
//                                     .replacingOccurrences(of: " ", with: "")
//                                     .replacingOccurrences(of: "-", with: "")
//                                 if let url = URL(string: phone), UIApplication.shared.canOpenURL(url) {
//                                     UIApplication.shared.open(url)
//                                 }
//                             }
//                     }
//                     HStack {
//                         Image(systemName: "globe")
//                             .foregroundColor(.sage)
//                             .frame(width: 30)
//                         Text("Visit Website")
//                             .foregroundColor(.azul)
//                             .onTapGesture {
//                                 if let url = URL(string: dispensary.url), UIApplication.shared.canOpenURL(url) {
//                                     UIApplication.shared.open(url)
//                                 }
//                             }
//                     }
//                 }
//                 Section(header: Text("HOURS OF OPERATION")) {
//                     ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
//                         if let hours = dispensary.hours[day] {
//                             HStack {
//                                 Text(day)
//                                     .fontWeight(.medium)
//                                 Spacer()
//                                 Text(hours)
//                                     .foregroundColor(.secondary)
//                             }
//                         }
//                     }
//                 }
//                 Section {
//                     Button(action: {
//                         viewModel.openInMaps(dispensary: dispensary)
//                     }) {
//                         HStack {
//                             Spacer()
//                             Image(systemName: "map.fill")
//                             Text("Get Directions")
//                                 .fontWeight(.bold)
//                             Spacer()
//                         }
//                     }
//                     .foregroundColor(.white)
//                     .padding()
//                     .background(Color.sage)
//                     .cornerRadius(10)
//                 }
//                 .listRowInsets(EdgeInsets())
//                 .padding()
//             }
//             .listStyle(InsetGroupedListStyle())
//             .navigationBarTitle("Dispensary Details", displayMode: .inline)
//             .navigationBarItems(trailing: Button("Close") {
//                 presentationMode.wrappedValue.dismiss()
//             })
//         }
//     }
// }

// struct DispensaryListView: View {
//     @ObservedObject var viewModel: DispensaryViewModel
//     @State private var selectedDispensary: Dispensary?
//     @State private var showDetailSheet = false
    
//     var body: some View {
//         List(viewModel.dispensaries) { dispensary in
//             Button(action: {
//                 selectedDispensary = dispensary
//                 showDetailSheet = true
//             }) {
//                 HStack {
//                     VStack(alignment: .leading, spacing: 5) {
//                         Text(dispensary.name)
//                             .font(.headline)
//                         Text(dispensary.address)
//                             .font(.subheadline)
//                             .foregroundColor(.secondary)
//                     }
//                     Spacer()
//                     Image(systemName: "chevron.right")
//                         .foregroundColor(.sage)
//                 }
//                 .padding(.vertical, 5)
//             }
//             .buttonStyle(PlainButtonStyle())
//         }
//         .listStyle(InsetGroupedListStyle())
//         .sheet(isPresented: $showDetailSheet) {
//             if let dispensary = selectedDispensary {
//                 DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
//             }
//         }
//     }
// }




import SwiftUI
import MapKit
import CoreLocation 

// MARK: - Data Model
struct Dispensary: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let phone: String
    let hours: [String: String]
    let url: String
    var coordinate: CLLocationCoordinate2D?

    
    var mapItem: MKMapItem? {
        guard let coordinate = coordinate else { return nil }
        let placemark = MKPlacemark(coordinate: coordinate)
        let item = MKMapItem(placemark: placemark)
        item.name = name
        return item
    }
}


enum AnnotationType: Identifiable {
    case dispensary(Dispensary)
    case userLocation(CLLocationCoordinate2D)

    // Stable identifier for each annotation type
    var id: String {
        switch self {
        case .dispensary(let dispensary):
            return dispensary.id.uuidString
        case .userLocation(let coordinate):
            return "userLocationAnnotation"
        }
    }

    // Coordinate for the annotation
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .dispensary(let dispensary):
            // Force unwrap coordinate as we filter nil coordinates before mapping
            return dispensary.coordinate!
        case .userLocation(let coordinate):
            return coordinate
        }
    }
}


// MARK: - ViewModel
// Make ViewModel conform to NSObject & CLLocationManagerDelegate
class DispensaryViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var dispensaries: [Dispensary] = [] // Geocoded dispensaries
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -83.0444), // Default to Detroit center
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15) // Wider initial span
    )
    @Published var userLocation: CLLocation? // User's current location
    @Published var locationError: Error? // Any location errors
    @Published var authorizationStatus: CLAuthorizationStatus // Current location permission status

    private let geocoder = CLGeocoder()
    private var dispensariesData: [Dispensary] = [] // Raw data before geocoding
    private let locationManager = CLLocationManager() // Manages location updates

    override init() {
        // Get initial authorization status BEFORE calling super.init()
        authorizationStatus = locationManager.authorizationStatus
        super.init() // Essential when inheriting from NSObject

        // Configure the Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // Balance accuracy and power

        // Load initial dispensary data
        setupData()
        // Start geocoding addresses
        geocodeNext(index: 0)
        // Request location permission from the user
        requestLocationPermission()
    }

    // MARK: Location Management
    func requestLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() // Ask for permission
        case .restricted, .denied:
            print("Location access restricted or denied.")
            // Update UI or state to inform the user if needed
            self.locationError = NSError(domain: "LocationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied or restricted."])
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access already granted.")
            locationManager.startUpdatingLocation() // Start getting locations immediately
        @unknown default:
            print("Unknown authorization status.")
            // Handle future cases if necessary
        }
    }

    // Delegate method: Called when location updates are available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.userLocation = locations.last // Update published property
            self.locationError = nil // Clear previous errors
            print("User location updated: \(self.userLocation?.coordinate ?? CLLocationCoordinate2D())")
             // You could optionally adjust the map region here, e.g., one time
        }
    }

    // Delegate method: Called when location manager fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            print("Location manager failed with error: \(error.localizedDescription)")
            self.locationError = error
        }
    }

    // Delegate method: Called when authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         DispatchQueue.main.async {
             let newStatus = manager.authorizationStatus
             self.authorizationStatus = newStatus // Update published status
             print("Authorization status changed: \(newStatus.rawValue)")

             if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                 // Permission was just granted
                 manager.startUpdatingLocation()
             } else if newStatus == .denied || newStatus == .restricted {
                 // Permission was just denied or restricted
                 manager.stopUpdatingLocation()
                 self.userLocation = nil // Clear location data
                 self.locationError = NSError(domain: "LocationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied or restricted."])
             }
         }
     }

    private func setupData() {
        dispensariesData = [
            Dispensary(
                name: "The Clinic Detroit",
                address: "13815 M-102, Detroit, MI 48235",
                phone: "(313) 539-8666",
                hours: [
                    "Friday": "9 AM–10 PM",
                    "Saturday": "9 AM–10 PM",
                    "Sunday": "9 AM–10 PM",
                    "Monday": "9 AM–10 PM",
                    "Tuesday": "9 AM–10 PM",
                    "Wednesday": "9 AM–10 PM",
                    "Thursday": "9 AM–10 PM"
                ],
                url: "https://weedmaps.com/dispensaries/the-clinic-detroit"
            ),
            Dispensary(
                name: "The House of Mary Jane",
                address: "19154 James Couzens Fwy, Detroit, MI 48235",
                phone: "(313) 340-9202",
                hours: [
                    "Friday": "9 AM–10 PM",
                    "Saturday": "9 AM–10 PM",
                    "Sunday": "9 AM–10 PM",
                    "Monday": "9 AM–10 PM",
                    "Tuesday": "9 AM–10 PM",
                    "Wednesday": "9 AM–10 PM",
                    "Thursday": "9 AM–10 PM"
                ],
                url: "https://www.leafly.com/dispensary-info/house-of-mary-jane"
            ),
            Dispensary(
                name: "Plan B Wellness Center",
                address: "20101 M-102, Detroit, MI 48219",
                phone: "(248) 470-4638",
                hours: [
                    "Friday": "9 AM–10 PM",
                    "Saturday": "9 AM–10 PM",
                    "Sunday": "9 AM–10 PM",
                    "Monday": "9 AM–10 PM",
                    "Tuesday": "9 AM–10 PM",
                    "Wednesday": "9 AM–10 PM",
                    "Thursday": "9 AM–10 PM"
                ],
                url: "https://weedmaps.com/dispensaries/plan-b-wellness-center-detroit"
            ),
            Dispensary(
                name: "Shake & Bake",
                address: "20477 Schaefer Hwy, Detroit, MI",
                phone: "(313) 397-7926",
                hours: [
                    "Friday": "10 AM–9 PM",
                    "Saturday": "10 AM–9 PM",
                    "Sunday": "10 AM–8 PM",
                    "Monday": "10 AM–9 PM",
                    "Tuesday": "10 AM–9 PM",
                    "Wednesday": "10 AM–9 PM",
                    "Thursday": "10 AM–9 PM"
                ],
                url: "https://www.leafly.com/dispensary-info/s-and-b-resource-center"
            ),
            Dispensary(
                name: "The Jazz Cannabis Club",
                address: "16890 Telegraph Rd, Detroit, MI",
                phone: "(313) 636-2582",
                hours: [
                    "Friday": "9 AM–10 PM",
                    "Saturday": "9 AM–10 PM",
                    "Sunday": "9 AM–10 PM",
                    "Monday": "9 AM–10 PM",
                    "Tuesday": "9 AM–10 PM",
                    "Wednesday": "9 AM–10 PM",
                    "Thursday": "9 AM–10 PM"
                ],
                url: "https://dutchie.com/dispensary/jazz-club-2-detroit"
            )
        ]
    }

    private func geocodeNext(index: Int) {
        guard index < dispensariesData.count else {
            print("Geocoding finished.")
            return
        }
        let dispensary = dispensariesData[index]

        // Simple check to maybe avoid re-geocoding, adjust if needed
        guard dispensary.coordinate == nil else {
            DispatchQueue.main.async {
                 if !self.dispensaries.contains(where: { $0.id == dispensary.id }) {
                     self.dispensaries.append(dispensary)
                 }
                 // Short delay before next attempt if skipping
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                     self?.geocodeNext(index: index + 1)
                 }
            }
            return
        }

        print("Geocoding: \(dispensary.name)")
        geocoder.geocodeAddressString(dispensary.address) { [weak self] placemarks, error in
            guard let self = self else { return }
            var updatedDispensary = dispensary

            if let placemark = placemarks?.first, let location = placemark.location {
                updatedDispensary.coordinate = location.coordinate
                DispatchQueue.main.async {
                    if !self.dispensaries.contains(where: { $0.id == updatedDispensary.id }) {
                        self.dispensaries.append(updatedDispensary)
                        print("Geocoded and added: \(updatedDispensary.name)")
                    }
                    // Logic for adjusting map region (optional)
                    // if self.dispensaries.count == 1 && self.userLocation == nil { ... }
                }
            } else {
                print("Geocoding error for \(dispensary.name): \(error?.localizedDescription ?? "Unknown error")")
            }

            // Delay before next geocoding to avoid rate limiting errors
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { // Slightly increased delay
                self.geocodeNext(index: index + 1)
            }
        }
    }

    // MARK: Map Interaction
    func openInMaps(dispensary: Dispensary) {
        guard let mapItem = dispensary.mapItem else {
            print("Cannot open \(dispensary.name) in Maps: Missing coordinate.")
            return
        }
        // Open in Maps app for directions
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

// MARK: - Map View
struct MapView: View {
    // Use @StateObject if MapView CREATES the ViewModel, @ObservedObject if it's passed in
    @ObservedObject var viewModel: DispensaryViewModel
    @State private var selectedDispensary: Dispensary? // For showing detail sheet
    @State private var showDetailSheet = false

    // Computed property combining dispensaries and user location for map annotations
    private var mapAnnotations: [AnnotationType] {
        // Start with geocoded dispensaries
        var annotations = viewModel.dispensaries
            .filter { $0.coordinate != nil } // Ensure coordinate exists
            .map { AnnotationType.dispensary($0) } // Convert to AnnotationType

        // Add user location if available
        if let userCoord = viewModel.userLocation?.coordinate {
            annotations.append(AnnotationType.userLocation(userCoord))
        }
        return annotations
    }

    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: mapAnnotations) { annotationItem in
            // Create annotation view based on the type
            MapAnnotation(coordinate: annotationItem.coordinate) {
                switch annotationItem {
                case .dispensary(let dispensary):
                    // Dispensary Annotation (Spaceship icon)
                    Button(action: {
                        selectedDispensary = dispensary
                        showDetailSheet = true
                    }) {
                        VStack(spacing: 2) { // Reduced spacing
                            ZStack {
                                Circle()
                                    .fill(Color.sage) // Use defined sage color
                                    .frame(width: 48, height: 48) // Slightly smaller circle
                                    .shadow(radius: 3)
                                Image("spaceship2") // Ensure asset exists
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35) // Slightly smaller image
                            }
                            Text(dispensary.name)
                                .font(.caption)
                                .fontWeight(.bold)
                                .lineLimit(1) // Prevent wrapping
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.white.opacity(0.85))
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                case .userLocation:
                    Circle()
                   
                    Image("me")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(.sage)
        .sheet(isPresented: $showDetailSheet) {
           
            if let dispensary = selectedDispensary {
                 DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
            }
        }
        .overlay(alignment: .top) {
             // Floating Title Overlay
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.sage)
                Text("Detroit Dispensaries")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(10)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.top, 50)
        }
        .overlay(alignment: .bottom) {
            Group {
                 if viewModel.authorizationStatus == .denied || viewModel.authorizationStatus == .restricted {
                     Text("Location access denied. Enable in Settings.")
                         .font(.caption)
                         .foregroundColor(.white)
                         .padding(.horizontal)
                         .padding(.vertical, 8)
                         .background(Color.black.opacity(0.7))
                         .cornerRadius(10)

                 } else if let error = viewModel.locationError {
                     Text("Location Error: \(error.localizedDescription)")
                         .font(.caption)
                         .foregroundColor(.red)
                         .padding(.horizontal)
                         .padding(.vertical, 8)
                         .background(.ultraThinMaterial)
                         .cornerRadius(10)
                 }
            }
             .padding(.bottom, 10) // Padding from bottom edge
         }
        .onAppear {
           viewModel.requestLocationPermission()
        }
    }
}

// MARK: - Detail View
struct DispensaryDetailView: View {
    let dispensary: Dispensary
    // Use @ObservedObject if viewModel might change data displayed here
    @ObservedObject var viewModel: DispensaryViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("INFORMATION")) {
                    HStack {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(.sage) // Use defined sage color
                            .frame(width: 30, alignment: .center)
                        Text(dispensary.name)
                            .font(.headline)
                    }
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.sage)
                            .frame(width: 30, alignment: .center)
                        Text(dispensary.address)
                    }
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.sage)
                            .frame(width: 30, alignment: .center)
                        // Make phone number tappable
                        Button(dispensary.phone) {
                            let phone = "tel://" + dispensary.phone.filter { "0123456789".contains($0) }
                            if let url = URL(string: phone), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }
                         .foregroundColor(.primary) // Use default text color for button label
                    }
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.sage)
                            .frame(width: 30, alignment: .center)
                        // Make website tappable
                        Button("Visit Website") {
                             if let url = URL(string: dispensary.url), UIApplication.shared.canOpenURL(url) {
                                 UIApplication.shared.open(url)
                             }
                         }
                         .foregroundColor(.azul) // Use defined azul color
                    }
                }

                Section(header: Text("HOURS OF OPERATION")) {
                    // Ensure consistent day order
                    ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                        if let hours = dispensary.hours[day] {
                            HStack {
                                Text(day)
                                    .fontWeight(.medium)
                                    .frame(width: 100, alignment: .leading) // Align days
                                Spacer()
                                Text(hours)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            HStack { // Show if hours for a day are missing
                                Text(day).fontWeight(.medium).frame(width: 100, alignment: .leading)
                                Spacer()
                                Text("N/A").foregroundColor(.secondary)
                            }
                        }
                    }
                }

                Section { // Section for the Button
                    Button(action: {
                        viewModel.openInMaps(dispensary: dispensary)
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "map.fill")
                            Text("Get Directions")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.sage)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                }
             
                 .listRowInsets(EdgeInsets())
                 .listRowBackground(Color.clear)
                 .frame(maxWidth: .infinity, alignment: .center)


            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(dispensary.name) // Use dispensary name as title
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .tint(.azul)
                }
            }
        }
    }
}


// MARK: - List View
struct DispensaryListView: View {
    @ObservedObject var viewModel: DispensaryViewModel
    @State private var selectedDispensary: Dispensary?
    @State private var showDetailSheet = false

    var body: some View {
        NavigationView {
            List(viewModel.dispensaries) { dispensary in
                // Use Button for the whole row to make it tappable
                Button {
                    selectedDispensary = dispensary
                    showDetailSheet = true
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(dispensary.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(dispensary.address)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
                 .buttonStyle(PlainButtonStyle())
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Dispensaries")
            .sheet(isPresented: $showDetailSheet) {
                // Present detail view when a row is tapped
                if let dispensary = selectedDispensary {
                    DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
                }
            }
        }
    }
}



