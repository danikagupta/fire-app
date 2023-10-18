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
        grid1 = [[Int]](repeating:[Int](repeating:3,count:gridSize),count:gridSize)
        grid2 = [[Int]](repeating:[Int](repeating:3,count:gridSize),count:gridSize)
        grid3 = [[Int]](repeating:[Int](repeating:3,count:gridSize),count:gridSize)
        print("FInished initialization of GridModel")
    }
    
    func populateGridData(from urlStr:String){
        print("Starting populate-grid-data with URL=\(urlStr)")
        guard let url = URL(string: urlStr) else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if let data = data{
                print("Got response from CSV file")
                var tmpGrid1=[[Int]](repeating: [Int](repeating: 1, count: gridSize), count: gridSize)
                var tmpGrid2=[[Int]](repeating: [Int](repeating: 2, count: gridSize), count: gridSize)
                var tmpGrid3=[[Int]](repeating: [Int](repeating: 3, count: gridSize), count: gridSize)
                
                print("Finished initialization from CSV file")
                let csvString = String(decoding: data, as: UTF8.self)
                let rows = csvString.components(separatedBy: "\n").filter { !$0.isEmpty }
                var i=0
                for row in rows {
                    let va = row.components(separatedBy: ",")
                    let values = row.components(separatedBy: ",").compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
                    //print("Row is \(row) and values are:\(values)")
                    if(va[0]=="RECORD_NUM") {
                        print("At row 1")
                    } else {
                        //print("In a data row")
                        let row_index=Int(va[1])!
                        let col_index=Int(va[2])!
                        let v1=Int(va[14])
                        let v2=Int(va[15])
                        let v3=Int(va[16])
                        tmpGrid1[row_index][col_index]=v1!
                        tmpGrid2[row_index][col_index]=v2!
                        tmpGrid3[row_index][col_index]=v3!
                        //print("Extracted values ri=\(row_index),ci=\(col_index),v1=\(v1),v2=\(v2),v3=\(v3)")
                    }
                }
                DispatchQueue.main.async {
                    self.grid1 = tmpGrid1
                    self.grid2 = tmpGrid2
                    self.grid3 = tmpGrid3
                    print("Switched to the new grid")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
        }
        
}
