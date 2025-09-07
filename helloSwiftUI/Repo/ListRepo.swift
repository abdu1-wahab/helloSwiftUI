import CoreData
import Foundation

protocol TaskListRepositoryProtocol {
    func create(name: String, iconName: String, iconColor: String) async throws
    func delete(_ list: TaskList) async throws
    func fetchAll() async throws -> [TaskList]
}

final class TaskListRepository: TaskListRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }

    func create(name: String, iconName: String, iconColor: String) async throws {
        let list = TaskList(context: context)
        list.id = UUID()
        list.name = name
        list.iconName = iconName
        list.iconColor = iconColor
        list.createdAt = Date()
        try context.save()
    }

    func delete(_ list: TaskList) async throws {
        context.delete(list)
        try context.save()
    }

    func fetchAll() async throws -> [TaskList] {
        let request: NSFetchRequest<TaskList> = TaskList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        return try context.fetch(request)
    }
}
