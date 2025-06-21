//import Foundation
//import SwiftData
//
//class ToDoListManager {
//    let context: ModelContext
//
//    init(context: ModelContext) {
//        self.context = context
//    }
//
//    // MARK: - Create
//
//    func createList(title: String, iconName: String) -> ToDoList {
//        let newList = ToDoList(title: title, iconName: iconName)
//        context.insert(newList)
//        try? context.save()
//        return newList
//    }
//
//    func createTask(
//        in list: ToDoList,
//        title: String,
//        details: String? = nil,
//        startDate: Date = .now,
//        endDate: Date? = nil
//    ) -> Task {
//        let task = Task(title: title, details: details, startDate: startDate, endDate: endDate, list: list)
//        context.insert(task)
//        try? context.save()
//        return task
//    }
//
//    // MARK: - Read
//
//    func fetchAllLists() -> [ToDoList] {
//        let descriptor = FetchDescriptor<ToDoList>(sortBy: [.init(\.title)])
//        return (try? context.fetch(descriptor)) ?? []
//    }
//
//    func fetchTasks(for list: ToDoList) -> [Task] {
//        let descriptor = FetchDescriptor<Task>(
//            predicate: #Predicate { $0.list == list },
//            sortBy: [.init(\.startDate)]
//        )
//        return (try? context.fetch(descriptor)) ?? []
//    }
//
//    // MARK: - Update
//
//    func markTask(_ task: Task, completed: Bool) {
//        task.isCompleted = completed
//        try? context.save()
//    }
//
//    func updateList(_ list: ToDoList, newTitle: String, newIcon: String) {
//        list.title = newTitle
//        list.iconName = newIcon
//        try? context.save()
//    }
//
//    // MARK: - Delete
//
//    func deleteList(_ list: ToDoList) {
//        context.delete(list) // cascade deletes tasks
//        try? context.save()
//    }
//
//    func deleteTask(_ task: Task) {
//        context.delete(task)
//        try? context.save()
//    }
//}
