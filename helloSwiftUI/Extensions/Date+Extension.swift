import Foundation

extension Date {
    static var firstDayOfWeek = Calendar.current.firstWeekday
       
       static var fullMonthNames: [String] {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale.current

           return (1...12).compactMap { month in
               dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
               let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
               return date.map { dateFormatter.string(from: $0) }
           }
       }

    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }

   var firstWeekDayBeforeStart: Date {
       let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
       var numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
       if numberFromPreviousMonth < 0 {
           numberFromPreviousMonth += 7
       }
       return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
   }

    var calendarDisplayDays: [Date] {
       var days: [Date] = []
       let firstDisplayDay = firstWeekDayBeforeStart
       var day = firstDisplayDay
       while day < startOfMonth {
           days.append(day)
           day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
       }
        
       for dayOffset in 0..<numberOfDaysInMonth {
           let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
           days.append(newDay!)
       }
       return days
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }

    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var randomDateWithinLastThreeMonths: Date {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: self)!
        let randomTimeInterval = TimeInterval.random(in: 0.0..<self.timeIntervalSince(threeMonthsAgo))
        let randomDate = threeMonthsAgo.addingTimeInterval(randomTimeInterval)
        return randomDate
    }
    
    var startOfMonth: Date {
            Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        }

    static var capitalizedShortWeekdays: [String] {
        let weekdays = Calendar.current.shortWeekdaySymbols
        let firstWeekdayIndex = Calendar.current.firstWeekday - 1
        let reordered = Array(weekdays[firstWeekdayIndex...] + weekdays[..<firstWeekdayIndex])
        return reordered
    }
    
    var formattedDateWithWeekDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d, yyyy"
        return formatter.string(from: self)
    }
}

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components)!
    }

    func endOfMonth(for date: Date) -> Date {
        guard let start = self.date(from: dateComponents([.year, .month], from: date)) else {
            fatalError("Could not get start of month")
        }
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return self.date(byAdding: components, to: start)!
    }
}
