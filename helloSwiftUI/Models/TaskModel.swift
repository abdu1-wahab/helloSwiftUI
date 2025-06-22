import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var taskDescription: String?
    @NSManaged var createdAt: Date
    @NSManaged var dueDate: Date?
    @NSManaged var time: Date?
    @NSManaged var isCompleted: Bool
    @NSManaged var list: TaskList?
}

extension Task {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
}
