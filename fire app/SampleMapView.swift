//
//  SampleMapView.swift
//  fire app
//
//  Created by Amit Gupta on 10/6/23.
//

import SwiftUI
import MapKit

struct SampleMapView: View {
    @ObservedObject var locationManager : LocationManager
    @Binding var tabSelect:Int
    
    @State var tabClickCount=0
    @State var showEmail=false
    
    @State var recipients = ["amit@gprof.com"]
    @State var subject = "My email subject"
    @State var msgbody = "<p>This is my email body for the trash location system.</p>"
    //@State var image = UIImage(named: "trash")
    
    @State private var selectedAnnotation: Annotation?

    
    func mapMidPointAndSpan() -> MKCoordinateRegion {
        var min_lat=DataStore.annotations[0].coordinate.latitude
        var max_lat=DataStore.annotations[0].coordinate.latitude
        var min_lon=DataStore.annotations[0].coordinate.longitude
        var max_lon=DataStore.annotations[0].coordinate.longitude
        for a in DataStore.annotations {
            let lat_a=a.coordinate.latitude
            let lon_a=a.coordinate.longitude
            min_lat=min(lat_a,min_lat)
            max_lat=max(lat_a,min_lat)
            min_lon=min(lon_a,min_lon)
            max_lon=max(lon_a,min_lon)
        }
        let mid_lat=0.5*(min_lat+max_lat)
        let mid_lon=0.5*(min_lon+max_lon)
        let span_lat=(max_lat-min_lat)*1.2+0.2
        let span_lon=(max_lon-min_lon)*1.2+0.2
        return MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: mid_lat, longitude: mid_lon),span:MKCoordinateSpan(latitudeDelta: span_lat, longitudeDelta: span_lon))
    }
    
    func createMapImage() -> UIImage {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        mapSnapshotOptions.region = mapMidPointAndSpan()
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)
        mapSnapshotOptions.showsBuildings = false
        //mapSnapshotOptions.showsPointsOfInterest = false
        
        let snapshotter = MKMapSnapshotter(options: mapSnapshotOptions)
        var image: UIImage!
        let semaphore = DispatchSemaphore(value: 0)
        
        snapshotter.start(with: DispatchQueue.global(qos: .userInitiated)) { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("Error taking snapshot: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            image = snapshot.image
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        return image
    }
    

    var body: some View {
        // Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 10.5, longitudeDelta: 10.5))), showsUserLocation: true, annotationItems: annotations)
        VStack {
            Text("My map")
                .font(.system(size: 42))
            Map(coordinateRegion: .constant(mapMidPointAndSpan()), showsUserLocation: true, annotationItems: DataStore.getAnnotations())
            { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                        Image(systemName: "flame.circle.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                DataStore.selectedAnnotation = annotation
                                tabSelect=3
                                print("Map selected annotation \(annotation)")
                            }
                    }
//                MapAnnotation(coordinate: annotation.coordinate) {
//                    VStack {
//                        Text(annotation.title)
//                            .font(.system(size: 24))
//                        //Text(annotation.subtitle).font(.system(size: 18))
//                    }
//                }
            }
            .onAppear {
                MKMapView.appearance().mapType = .mutedStandard
                MKMapView.appearance().pointOfInterestFilter = .excludingAll
                    }
            Button("Notify Authorities") {
                self.tabClickCount=self.tabClickCount+1
                print("Notify authoritites")
                let renderer = UIGraphicsImageRenderer(bounds: UIScreen.main.bounds)
                let screenshot = renderer.image { context in
                                    UIApplication.shared.windows.first?.rootViewController?.view.drawHierarchy(in: UIScreen.main.bounds, afterScreenUpdates: true)
                                }
                DataStore.mapScreen=screenshot
                //DataStore.mapScreen=createMapImage()
                
                showEmail = true
            }.padding(.all, 14.0)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)

        }.sheet(isPresented: $showEmail) {
            Text("Showing sheet")
            //EmailView(recipients: recipients, subject: subject, body: msgbody, image: DataStore.updatedImage, mapImage: DataStore.mapScreen)
        }

    }
}

