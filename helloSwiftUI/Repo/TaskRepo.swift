import CoreData
import Foundation

protocol TaskRepositoryProtocol {
    func create(_ task: TaskItem) async throws
    func delete(_ task: TaskItem) async throws
    func fetch(for list: TaskList) async throws -> [TaskItem]
    func toggleCompletion(_ task: TaskItem) async throws

    func countAllTasks() throws -> Int
    func countCompletedTasks() throws -> Int
    func countTasksDueToday() throws -> Int
    func fetchTaskStatusByDate(in month: Date) throws -> [TaskDaySummary]
    func fetchTasks(for date: Date) async throws -> [TaskItem]
    func countUpcomingTasks() throws -> Int
}

final class TaskRepository: TaskRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }

    func create(_ task: TaskItem) async throws {
        context.insert(task)
        try context.save()
    }

    func delete(_ task: TaskItem) async throws {
        context.delete(task)
        try context.save()
    }

    func fetch(for list: TaskList) async throws -> [TaskItem] {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "lists == %@", list)
        return try context.fetch(request)
    }

    func toggleCompletion(_ task: TaskItem) async throws {
        task.isCompleted.toggle()
        try context.save()
    }

    // MARK: - Dashboard Count Methods

    func countAllTasks() throws -> Int {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        return try context.count(for: request)
    }

    func countCompletedTasks() throws -> Int {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "isCompleted == YES")
        return try context.count(for: request)
    }

    func countTasksDueToday() throws -> Int {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!

        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "dueDate >= %@ AND dueDate < %@", startOfDay as NSDate, endOfDay as NSDate)
        return try context.count(for: request)
    }

    func countUpcomingTasks() throws -> Int {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "dueDate != nil AND isCompleted == NO")
        return try context.count(for: request)
    }
    
    func fetchTaskStatusByDate(in month: Date) throws -> [TaskDaySummary] {
        let calendar = Calendar.current
        let startOfMonth = calendar.startOfMonth(for: month)
        let endOfMonth = calendar.endOfMonth(for: month)
        
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "dueDate >= %@ AND dueDate < %@", startOfMonth as NSDate, endOfMonth as NSDate)

        let tasks = try context.fetch(request)

        // Group tasks by day
        let grouped = Dictionary(grouping: tasks, by: { calendar.startOfDay(for: $0.dueDate ?? Date()) })

        return grouped.map { (date, tasks) in
            let hasCompleted = tasks.contains(where: { $0.isCompleted })
            let hasIncomplete = tasks.contains(where: { !$0.isCompleted })
            return TaskDaySummary(date: date, hasCompleted: hasCompleted, hasIncomplete: hasIncomplete)
        }
    }
    
    func fetchTasks(for date: Date) async throws -> [TaskItem] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        request.predicate = NSPredicate(format: "dueDate >= %@ AND dueDate < %@", startOfDay as NSDate, endOfDay as NSDate)

        return try context.fetch(request)
    }

}
