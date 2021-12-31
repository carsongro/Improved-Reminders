//
//  ItemModel.swift
//  Reminders Improved
//
//  Created by Carson Gross on 12/30/21.
//

import Foundation
import UserNotifications

struct ItemModel: Identifiable, Codable {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    let id: String
    let title: String
    let isCompleted: Bool
    let selectedDate: Date
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, selectedDate: Date){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.selectedDate = selectedDate
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, selectedDate: selectedDate)
    }
}
