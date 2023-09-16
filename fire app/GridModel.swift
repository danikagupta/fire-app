//
//  GridModel.swift
//  fire app
//
//  Created by Siddhartha on 9/16/23.
//

import Foundation
import SwiftUI

class GridModel:ObservableObject{
    @Published var grid1: [[Int]] = []
    @Published var grid2: [[Int]] = []
    @Published var grid3: [[Int]] = []
    
    let gridSize = 64
    
    
    
    init(){
        grid1 = [[Int]](repeating:[Int](repeating:0,count:gridSize),count:gridSize)
        grid2 = [[Int]](repeating:[Int](repeating:0,count:gridSize),count:gridSize)
        grid3 = [[Int]](repeating:[Int](repeating:0,count:gridSize),count:gridSize)
    }
    
    func populateGridData(from url:String){
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            print("Returned from call")
            
        }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if let data = data{
                print("got response from csv")
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
