//
//  FireGridView.swift
//  fire app
//
//  Created by Siddhartha on 9/16/23.
//

import SwiftUI

struct FireGridView: View {
    @StateObject var viewModel = GridModel()
    let csvUrl="https://docs.google.com/spreadsheets/d/e/2PACX-1vQZvm9w8HmY-BNwAXYVo_paxreUqUSN975Je7rfUWEC1BkVv-ZOtl7LroIrHJMxwf3ME3nHmAKCrhVR/pub?gid=0&single=true&output=csv"
    
    var body: some View {
        VStack(spacing:0){
            Text("Fire Grid View")
            ForEach(0..<viewModel.gridSize, id: \.self) { row in
                                HStack(spacing: 0) {
                                    ForEach(0..<viewModel.gridSize, id: \.self) { column in
                                        Rectangle()
                                            .fill(.red)
                                            
                                            .frame(width: 2, height: 2)
                                    }
                                }
                            }
            Spacer()
            Text("First Grid")
            Spacer()
            Text("Second Grid")
            Spacer()
            Text("Third Grid")
        }
    }
}

struct FireGridView_Previews: PreviewProvider {
    static var previews: some View {
        FireGridView()
    }
}
