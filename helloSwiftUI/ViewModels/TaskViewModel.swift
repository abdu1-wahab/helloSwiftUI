import Foundation

@MainActor
final class TaskViewModel: ObservableObject {
    private let repository: TaskRepositoryProtocol

    @Published var tasks: [TaskItem] = []

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
        } catch {
            print("❌ Error creating task: \(error)")
        }
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
}
