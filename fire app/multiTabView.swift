//
//  multiTabView.swift
//  fire app
//
//  Created by Siddhartha on 10/5/22.
//

import SwiftUI
import WebKit


struct MultiTabView: View {
    @StateObject var locationManager = LocationManager()
    @State private var tabSelected=1

    var body: some View {
        TabView(selection:$tabSelected){
            WebView(url:URL(string:"https://sites.google.com/view/smokefinder/app-home-page")!)
                .tabItem{
                    Label("Information",systemImage: "flame.circle.fill")
                }
                .tag(1)
            SampleMapView(locationManager: locationManager,tabSelect:$tabSelected)
                .tabItem{
                    Label("Map View",systemImage: "flame.circle.fill")
                }
                .tag(2)
            FireGridView()
                .tabItem{
                    Label("Grid View",systemImage: "flame.circle.fill")
                }
                .tag(3)
            ContentView()
                .tabItem{
                    Label("Detect Fire",systemImage: "camera.circle.fill")
                }
                .tag(4)
            WebView(url:URL(string:"https://sites.google.com/view/smokefinder/continuing")!)
                .tabItem{
                    Label("Credits",systemImage: "quote.bubble.fill")
                }
                .tag(5)
           
        }
    }
}

struct Tab1View: View {
    var body: some View {
        Text("Page 1")
    }
}

struct Tab2View: View {
    var body: some View {
        Text("Page 2")
    }
}

struct Tab3View: View {
    var body: some View {
        Text("Page 3")
    }
}

struct MultiTabView_Previews: PreviewProvider {
    static var previews: some View {
        MultiTabView()
    }
}
