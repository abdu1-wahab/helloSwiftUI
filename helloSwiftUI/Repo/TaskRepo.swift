import CoreData
import Foundation

protocol TaskRepositoryProtocol {
    func create(_ task: Task) async throws
    func delete(_ task: Task) async throws
    func fetch(for list: TaskList) async throws -> [Task]
    func toggleCompletion(_ task: Task) async throws
}


final class TaskRepository: TaskRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }

    func create(_ task: Task) async throws {
        context.insert(task)
        try context.save()
    }

    func delete(_ task: Task) async throws {
        context.delete(task)
        try context.save()
    }

    func fetch(for list: TaskList) async throws -> [Task] {
        let request = Task.fetchRequest()
        request.predicate = NSPredicate(format: "list == %@", list)
        return try context.fetch(request)
    }

    func toggleCompletion(_ task: Task) async throws {
        task.isCompleted.toggle()
        try context.save()
    }
}

