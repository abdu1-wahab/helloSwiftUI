import Foundation

@MainActor
final class TaskViewModel: ObservableObject {
    private let repository: TaskRepositoryProtocol

    @Published var tasks: [Task] = []

    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }

    func loadTasks(for list: TaskList) async {
        do {
            tasks = try await repository.fetch(for: list)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }

    func toggleTask(_ task: Task) async {
        do {
            try await repository.toggleCompletion(task)
            await loadTasks(for: task.list!)
        } catch {
            print("Error toggling: \(error)")
        }
    }
//    
//    func addTask(_ input: NewTaskInput, to list: TaskList) async {
//        do {
//            let task = Task(context: CoreDataManager.shared.context)
//            task.id = UUID()
//            task.title = input.title
//            task.taskDescription = input.description
//            task.createdAt = Date()
//            task.isCompleted = false
//            task.list = list
//
//            try await taskRepository.create(task)
//            await loadTasks(for: list)
//        } catch {
//            print("❌ Error creating task: \(error)")
//        }
//    }
//
}
