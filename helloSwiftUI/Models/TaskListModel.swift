import Foundation
import CoreData

@objc(TaskList)
class TaskList: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var iconName: String
    @NSManaged var createdAt: Date
    @NSManaged var tasks: Set<TaskItem>?
}

extension TaskList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskList> {
        return NSFetchRequest<TaskList>(entityName: "TaskList")
    }
}

struct TaskListEntry {
    var name: String
    var icon: String
}
