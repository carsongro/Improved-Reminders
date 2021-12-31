//
//  ListRowView.swift
//  Reminders Improved
//
//  Created by Carson Gross on 12/30/21.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
            Text(item.dateFormatter.string(from: item.selectedDate))
                .font(.headline)
            
        }
        .font(.title2)
        .padding(.vertical, 8)
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "first item!", isCompleted: false, selectedDate: Date())
    static var item2 = ItemModel(title: "Second Item.", isCompleted: true, selectedDate: Date())
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
