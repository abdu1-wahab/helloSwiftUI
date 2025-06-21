import Foundation
import SwiftData

@Model
class ToDoList {
    var title: String
    var iconName: String
    
    @Relationship(deleteRule: .cascade, inverse: \Task.list)
    var tasks: [Task] = []

    init(title: String, iconName: String) {
        self.title = title
        self.iconName = iconName
    }
}

@Model
class Task {

    var title: String
    var details: String?
    var startDate: Date
    var endDate: Date?
    var isCompleted: Bool = false

    var list: ToDoList?

    init(title: String, details: String? = nil, startDate: Date, endDate: Date? = nil, list: ToDoList? = nil) {
        self.title = title
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.list = list
    }
}

