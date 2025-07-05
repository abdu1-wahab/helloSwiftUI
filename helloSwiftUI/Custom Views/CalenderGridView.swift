import Foundation
import SwiftUI

struct CalendarGridView: View {
    let referenceDate: Date
    @Binding var selectedDate: Date
    
    @State private var days: [Date] = []
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        var days = referenceDate.calendarDisplayDays
        let columns = Array(repeating: GridItem(.flexible()), count: 7)

        LazyVGrid(columns: columns) {
            ForEach(days, id: \.self) { day in
                if day.monthInt != referenceDate.monthInt {
                    Text("")
                } else {
                    Text("\(day.dayInt)")
                        .fontWeight(.bold)
                        .foregroundStyle(selectedDate.startOfDay == day.startOfDay ? Color(hex: "E5E7EB") : .secondary)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            Circle()
                                .fill(selectedDate.startOfDay == day.startOfDay ? Color(hex: "3B82F6") : Color.clear)
                        )
                        .onTapGesture {
                            selectedDate = day
                            print("Selected: \(day)")
                        }
                }
            }
        }
        .onAppear {
            days = referenceDate.calendarDisplayDays
        }
        .onChange(of: referenceDate) { newValue in
            days = newValue.calendarDisplayDays
        }
    }
}

//#Preview {
//    CalenderGridView()
//}
