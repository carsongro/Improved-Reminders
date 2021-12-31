//
//  Reminders_ImprovedApp.swift
//  Reminders Improved
//
//  Created by Carson Gross on 12/30/21.
//

import SwiftUI

@main
struct Reminders_ImprovedApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
