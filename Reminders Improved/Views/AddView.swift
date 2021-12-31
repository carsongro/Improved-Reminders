//
//  AddView.swift
//  Reminders Improved
//
//  Created by Carson Gross on 12/30/21.
//

import SwiftUI
import UserNotifications

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var selectedDate: Date = Date()
    @State var frequency: Double = 0;
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Start typing...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.regularMaterial)
                .cornerRadius(12)
                VStack{
                    Text("Selected date and time:")
                        .font(.headline)
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.headline)
                    DatePicker("Select a date", selection: $selectedDate)
                        .font(.headline)
                        .accentColor(Color.pink)
                        .datePickerStyle(
                            CompactDatePickerStyle()
                        )
                }
                Button(action: saveButtonPressed, label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                    
            }
            .padding(14)
        }
        .navigationTitle("Add a reminder")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error: \(error)")
            }
            else{
                print("Success")
            }
        }
    }
    
    func scheduleNotification(components: DateComponents, frequency: Double, reminderText: String) {
        if(frequency == 0){
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.subtitle = reminderText
            content.sound = .default
            content.badge = 1
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString,content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        else{
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.subtitle = reminderText
            content.sound = .default
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (frequency*60*60), repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString,content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText, selectedDate: selectedDate)
            requestAuthorization()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: selectedDate)
            scheduleNotification(components: components, frequency: frequency, reminderText: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 1 {
            alertTitle = "Your entry cannot be blank"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
