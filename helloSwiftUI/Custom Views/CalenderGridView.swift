import Foundation
import SwiftUI

struct CalendarGridView: View {
    let referenceDate: Date
    @Binding var selectedDate: Date
    let taskSummaries: [TaskDaySummary]
    
    @State private var days: [Date] = []
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(days, id: \.self) { day in
                if day.monthInt != referenceDate.monthInt {
                    Text("")
                        .frame(height: 40)
                } else {
                    VStack(spacing: 4) {
                        Text("\(day.dayInt)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(selectedDate.startOfDay == day.startOfDay ? Color(hex: "E5E7EB") : .secondary)
                            .frame(maxWidth: .infinity, minHeight: 28)
                            .background(
                                Circle()
                                    .fill(selectedDate.startOfDay == day.startOfDay ? Color(hex: "3B82F6") : Color.clear)
                            )
                        
                        // Indicator dot(s)
                        if let summary = taskSummaries.first(where: { $0.date.startOfDay == day.startOfDay }) {
                            HStack(spacing: 4) {
                                if summary.hasIncomplete {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 6, height: 6)
                                }
                                if summary.hasCompleted {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 6, height: 6)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        selectedDate = day
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
