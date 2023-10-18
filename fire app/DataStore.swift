//
//  DataStore.swift
//  fire app
//
//  Created by Amit Gupta on 10/6/23.
//

import Foundation
import MapKit


struct Annotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let url: String
}

class DataStore {
    
    static var label = "UNKNOWN"
    static var lat: Double = 0.0
    static var lon: Double = 0.0
    static var seen: Bool = false
    static var updatedImage=UIImage(named: "fire")
    static var mapScreen:UIImage? = nil
    static var selectedAnnotation = Annotation(coordinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), title: "Default Fire",
                                              url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZvm9w8HmY-BNwAXYVo_paxreUqUSN975Je7rfUWEC1BkVv-ZOtl7LroIrHJMxwf3ME3nHmAKCrhVR/pub?gid=0&single=true&output=csv")
    
    
    static var annotations = [
        Annotation(coordinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), title: "Pacheco Fire",
                   url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZvm9w8HmY-BNwAXYVo_paxreUqUSN975Je7rfUWEC1BkVv-ZOtl7LroIrHJMxwf3ME3nHmAKCrhVR/pub?gid=0&single=true&output=csv"),
        Annotation(coordinate: CLLocationCoordinate2D(latitude: 37.773972, longitude: -122.431297), title: "Sinclair Fire", 
                   url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZvm9w8HmY-BNwAXYVo_paxreUqUSN975Je7rfUWEC1BkVv-ZOtl7LroIrHJMxwf3ME3nHmAKCrhVR/pub?gid=0&single=true&output=csv"),
        Annotation(coordinate: CLLocationCoordinate2D(latitude: 37.689294003925625, longitude: -121.70600762975174), title: "SZU Fire",
                   url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZvm9w8HmY-BNwAXYVo_paxreUqUSN975Je7rfUWEC1BkVv-ZOtl7LroIrHJMxwf3ME3nHmAKCrhVR/pub?gid=0&single=true&output=csv")
        // 37.689294003925625, -121.70600762975174
    ]
    
    static func getAnnotations() -> [Annotation] {
        if seen {
            annotations.append(Annotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: label, url: ""))
        }
        print("Annotations are \(annotations)")
        return annotations
    }
}

