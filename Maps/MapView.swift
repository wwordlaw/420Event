import SwiftUI
import MapKit

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

class DispensaryViewModel: ObservableObject {
    @Published var dispensaries: [Dispensary] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.36, longitude: -83.10),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    private let geocoder = CLGeocoder()
    private var dispensariesData: [Dispensary] = []
    
    init() {
        setupData()
        geocodeNext(index: 0)
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
        guard index < dispensariesData.count else { return }
        let dispensary = dispensariesData[index]
        geocoder.geocodeAddressString(dispensary.address) { [weak self] placemarks, error in
            guard let self = self else { return }
            var updatedDispensary = dispensary
            if let placemark = placemarks?.first, let location = placemark.location {
                updatedDispensary.coordinate = location.coordinate
                DispatchQueue.main.async {
                    self.dispensaries.append(updatedDispensary)
                    if self.dispensaries.count == 1 {
                        self.region = MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        )
                    }
                }
            } else {
                print("Geocoding error for \(dispensary.name): \(error?.localizedDescription ?? "Unknown error")")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.geocodeNext(index: index + 1)
            }
        }
    }
    
    func openInMaps(dispensary: Dispensary) {
        guard let mapItem = dispensary.mapItem else { return }
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

struct MapView: View {
    @ObservedObject var viewModel: DispensaryViewModel
    @State private var selectedDispensary: Dispensary?
    @State private var showDetailSheet = false
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.dispensaries.filter { $0.coordinate != nil }) { dispensary in
            MapAnnotation(coordinate: dispensary.coordinate!) {
                Button(action: {
                    selectedDispensary = dispensary
                    showDetailSheet = true
                }) {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 44, height: 44)
                                .shadow(radius: 3)
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .bold))
                        }
                        Text(dispensary.name)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(5)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(.green)
        .sheet(isPresented: $showDetailSheet) {
            if let dispensary = selectedDispensary {
                DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
            }
        }
        .overlay(
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.green)
                Text("Detroit Dispensaries")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(10)
            .background(Color.white.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.top, 10),
            alignment: .top
        )
    }
}

struct DispensaryDetailView: View {
    let dispensary: Dispensary
    let viewModel: DispensaryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("INFORMATION")) {
                    HStack {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text(dispensary.name)
                            .font(.headline)
                    }
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text(dispensary.address)
                    }
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text(dispensary.phone)
                            .onTapGesture {
                                let phone = "tel://" + dispensary.phone
                                    .replacingOccurrences(of: "(", with: "")
                                    .replacingOccurrences(of: ")", with: "")
                                    .replacingOccurrences(of: " ", with: "")
                                    .replacingOccurrences(of: "-", with: "")
                                if let url = URL(string: phone), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text("Visit Website")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                if let url = URL(string: dispensary.url), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                }
                Section(header: Text("HOURS OF OPERATION")) {
                    ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                        if let hours = dispensary.hours[day] {
                            HStack {
                                Text(day)
                                    .fontWeight(.medium)
                                Spacer()
                                Text(hours)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                Section {
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
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .listRowInsets(EdgeInsets())
                .padding()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Dispensary Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct DispensaryListView: View {
    @ObservedObject var viewModel: DispensaryViewModel
    @State private var selectedDispensary: Dispensary?
    @State private var showDetailSheet = false
    
    var body: some View {
        List(viewModel.dispensaries) { dispensary in
            Button(action: {
                selectedDispensary = dispensary
                showDetailSheet = true
            }) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(dispensary.name)
                            .font(.headline)
                        Text(dispensary.address)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.green)
                }
                .padding(.vertical, 5)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showDetailSheet) {
            if let dispensary = selectedDispensary {
                DispensaryDetailView(dispensary: dispensary, viewModel: viewModel)
            }
        }
    }
}
