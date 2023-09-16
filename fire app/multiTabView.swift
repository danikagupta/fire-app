//
//  multiTabView.swift
//  fire app
//
//  Created by Siddhartha on 10/5/22.
//

import SwiftUI
import WebKit

struct MultiTabView: View {
    var body: some View {
        TabView{
            WebView(url:URL(string:"https ://sites.google.com/view/smokefinder/app-home-page")!)
                .tabItem{
                    Label("Information",systemImage: "flame.circle.fill")
                }
            FireGridView()
                .tabItem{
                    Label("Grid View",systemImage: "flame.circle.fill")
                }
            ContentView()
                .tabItem{
                    Label("Detect Fire",systemImage: "camera.circle.fill")
                }
            WebView(url:URL(string:"https://sites.google.com/view/smokefinder/continuing")!)
                .tabItem{
                    Label("Credits",systemImage: "quote.bubble.fill")
                }
           
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
