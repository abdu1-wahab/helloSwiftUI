import Foundation
import SSDateTimePicker

@MainActor
final class TaskViewModel: ObservableObject {
    private let repository: TaskRepositoryProtocol

    @Published var tasks: [TaskItem] = []
    @Published var taskDaySummaries: [TaskDaySummary] = []
    @Published var tasksForSelectedDate: [TaskItem] = []

    // Dashboard stats
    @Published var allCount: Int = 0
    @Published var completedCount: Int = 0
    @Published var todayCount: Int = 0
    @Published var upcomingCount: Int = 0

    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
    
    func addTask(title: String, desc: String, list: TaskList, dueDate: Date, endTime: Date) async {
        let task = TaskItem(context: CoreDataManager.shared.context)
        task.id = UUID()
        task.title = title
        task.taskDescription = desc
        task.createdAt = Date()
        task.dueDate = dueDate
        task.dueTime = endTime
        task.isCompleted = false
        task.lists = list

        do {
            try await repository.create(task)
            await loadTasks(for: list)
            scheduleNotification(for: task)
        } catch {
            print("❌ Error creating task: \(error)")
        }
    }
    
    private func scheduleNotification(for task: TaskItem) {
        guard
            let listUUID = task.lists?.id,
            let dueDate = task.dueDate
        else {
            print("⚠️ Missing info for scheduling notification")
            return
        }
        
        let taskUUID = task.id
        let taskId = taskUUID.uuidString
        let listId = listUUID.uuidString
        let title = task.title

        NotificationManager.shared.scheduleNotification(
            id: taskId,
            title: title,
            listId: listId,
            date: dueDate
        )
    }
    
    // Load tasks for a specific list
    func loadTasks(for list: TaskList) async {
        do {
            tasks = try await repository.fetch(for: list)
        } catch {
            print("❌ Error fetching tasks: \(error)")
        }
    }

    // Toggle task completion
    func toggleTask(_ task: TaskItem) async {
        do {
            try await repository.toggleCompletion(task)
            await loadTasks(for: task.lists!)
        } catch {
            print("❌ Error toggling: \(error)")
        }
    }
    
    func deleteTask(_ task: TaskItem) async {
        do {
            try await repository.delete(task)
            if let list = task.lists {
                await loadTasks(for: list)
            }
        } catch {
            print("❌ Error deleting task: \(error)")
        }
    }

    // Load global dashboard stats
    func loadDashboardCounts() async {
        do {
            allCount = try repository.countAllTasks()
            completedCount = try repository.countCompletedTasks()
            todayCount = try repository.countTasksDueToday()
            upcomingCount = try repository.countUpcomingTasks()
        } catch {
            print("❌ Error loading dashboard counts: \(error)")
        }
    }
    
    // load all tasks summary i.e. complete & incomplete status
    func loadTaskSummaries(for month: Date) async {
        do {
            let summaries = try repository.fetchTaskStatusByDate(in: month)
            await MainActor.run {
                self.taskDaySummaries = summaries
            }
        } catch {
            print("❌ Error fetching summaries: \(error)")
        }
    }
    
    func loadTasks(for date: Date) async {
        do {
            let result = try await repository.fetchTasks(for: date)
            await MainActor.run {
                self.tasksForSelectedDate = result
            }
        } catch {
            print("❌ Error loading tasks for date: \(error)")
        }
    }

}
