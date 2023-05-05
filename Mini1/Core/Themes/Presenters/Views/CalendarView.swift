//
//  CalendarView.swift
//  Mini1
//
//  Created by Randy Julian on 29/04/23.
//
import SwiftUI
import UIKit
import FSCalendar

struct CalendarView: View {
    @State var showError: Bool = false
    @Binding var selectedDate: Date
    @Binding var isFilled: Bool
    @Binding var showSheet: Bool
    @ObservedObject var entryViewModel: EntryViewModel    

    var body: some View {
        VStack {
            CalendarViewRepresentable(selectedDate: $selectedDate, isFilled: $isFilled, showSheet: $showSheet, entryViewModel: entryViewModel, showError: $showError)
                .padding(.bottom)
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth:350, maxHeight: 400)
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Wait"),
                message: Text("It is not time yet"),
                dismissButton: .default(Text("Come back next time"))
            )
        }
    }
}

struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    fileprivate var calendar = FSCalendar()
    @Binding var selectedDate: Date
    @Binding var isFilled: Bool
    @Binding var showSheet: Bool
    @ObservedObject var entryViewModel: EntryViewModel
    
    @Binding var showError: Bool
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.todayColor = UIColor(displayP3Red: 100, green: 100, blue: 0, alpha: 0)
        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.selectionColor = .blue
        calendar.appearance.eventDefaultColor = .green
//        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.titleFont = .systemFont(ofSize: 20)
//        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.appearance.headerMinimumDissolvedAlpha = 0.12
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 30, weight: .black)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.clipsToBounds = false
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarViewRepresentable
        
        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let todayDate = Date()
            parent.selectedDate = date
            parent.entryViewModel.selectedDateEntry.removeAll()
            
            if date <= todayDate {
                parent.showSheet = true
            } else {
                parent.showError = true
            }
            
            guard let sleepRoutine = parent.entryViewModel.getOneEntry(date: parent.selectedDate)
            else {
                parent.isFilled = false
                return
            }
            parent.entryViewModel.selectedDateEntry.append(sleepRoutine)
            parent.isFilled = true
            
        }
        
//        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//            let eventDates = [Date(), Date(),
//                                Date.now.addingTimeInterval(300000),
//                                Date.now.addingTimeInterval(100000),
//                                Date.now.addingTimeInterval(-600000),
//                                Date.now.addingTimeInterval(-1000000)]
//            var eventCount = 0
//            eventDates.forEach { eventDate in
//                if eventDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted){
//                    eventCount += 1;
//                }
//            }
//            return eventCount
//        }
        
        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//            if isWeekend(date: date) {
//                return false
//            }
            return true
        }
    }
}
func isWeekend(date: Date) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let day: String = dateFormatter.string(from: date)
    if day == "Saturday" || day == "Sunday" {
        return true
    }
    return false
}
