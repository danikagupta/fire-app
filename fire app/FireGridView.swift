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
    
    func oneRow(id:Int, rowId:Int) -> some View {
        ForEach(0..<viewModel.gridSize, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(0..<viewModel.gridSize/2, id: \.self) { column in
                    Rectangle()
                        .fill(colorForCell(id: id, row: row, column: column))
                        .frame(width: 4, height: 4)
                }
                Rectangle()
                    .fill(.orange)
                    .frame(width: 2, height: 2)
                ForEach(viewModel.gridSize/2..<viewModel.gridSize, id: \.self) { column in
                    Rectangle()
                        .fill(colorForCell(id: id, row: row, column: column))
                        .frame(width: 4, height: 4)
                }
            }
        }
    }
    
    func oneGridNew(id:Int,title:String) -> some View {
        Group {
            VStack(spacing:0) {
                ForEach(0..<viewModel.gridSize, id: \.self) { row in
                    oneRow(id: id, rowId: row)
                }
            }
            Text(title)
                .font(.system(size:30))
                .padding(10)
        }
    }
    
    func oneGrid(id:Int,title:String) -> some View {
        Group {
            VStack(spacing:0) {
                ForEach(0..<viewModel.gridSize/2, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.gridSize/2, id: \.self) { column in
                            Rectangle()
                                .fill(colorForCell(id: id, row: row, column: column))
                                .frame(width: 4, height: 4)
                        }
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 2, height: 2)
                        ForEach(viewModel.gridSize/2..<viewModel.gridSize, id: \.self) { column in
                            Rectangle()
                                .fill(colorForCell(id: id, row: row, column: column))
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                HStack(spacing: 0) {
                    ForEach(0..<viewModel.gridSize/2, id: \.self) { column in
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 4, height: 2)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 4, height: 2)
                    }
                }
                ForEach(viewModel.gridSize/2..<viewModel.gridSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.gridSize/2, id: \.self) { column in
                            Rectangle()
                                .fill(colorForCell(id: id, row: row, column: column))
                                .frame(width: 4, height: 4)
                        }
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 2, height: 2)
                        ForEach(viewModel.gridSize/2..<viewModel.gridSize, id: \.self) { column in
                            Rectangle()
                                .fill(colorForCell(id: id, row: row, column: column))
                                .frame(width: 4, height: 4)
                        }
                    }
                }
            }
            Text(title)
                .font(.system(size:30))
                .padding(10)
        }
    }
    
    var body: some View {
        VStack(spacing:40){
            Text(DataStore.selectedAnnotation.title)
                .font(.system(size: 36))
            Spacer()
            ScrollView{
                oneGrid(id: 1, title: "Fire: Previous day")
                Spacer()
                oneGrid(id: 2, title: "Fire: Predicted")
                Spacer()
                oneGrid(id: 3, title: "Fire: Next day")
            }
        }
        .onAppear {
            viewModel.populateGridData(from: DataStore.selectedAnnotation.url)
        }
    }
    
    func colorForNumber(number: Int) -> Color {
        switch number {
        case 1: return .red
        case 2: return .green
        case 3: return .blue
        default: return .black
        }
    }
    
    func colorForCell(id:Int, row: Int, column:Int) -> Color {
        //print("Fetching color for cell for row \(row) column \(column) initialized \(viewModel.initialized)")
        switch(id){
        case 1:
            return colorForNumber(number: viewModel.grid1[row][column])
        case 2:
            return colorForNumber(number: viewModel.grid2[row][column])
        case 3:
            return colorForNumber(number: viewModel.grid3[row][column])
        default:
            return .orange
        }
        
    }
}

struct FireGridView_Previews: PreviewProvider {
    static var previews: some View {
        FireGridView()
    }
}
