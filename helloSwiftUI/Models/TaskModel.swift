import Foundation
import CoreData

@objc(TaskItem)
class TaskItem: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var taskDescription: String?
    @NSManaged var createdAt: Date
    @NSManaged var dueDate: Date?
    @NSManaged var dueTime: Date?
    @NSManaged var isCompleted: Bool
    @NSManaged var lists: TaskList?
}

extension TaskItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }
}
