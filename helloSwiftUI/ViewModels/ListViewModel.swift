
import Foundation
@MainActor
final class TaskListViewModel: ObservableObject {
    private let repository: TaskListRepositoryProtocol

    @Published var lists: [TaskList] = []

    init(repository: TaskListRepositoryProtocol) {
        self.repository = repository
    }

    func loadLists() async {
        do {
            lists = try await repository.fetchAll()
        } catch {
            print("Error loading lists: \(error)")
        }
    }

    func createList(name: String, iconName: String) async {
        do {
            try await repository.create(name: name, iconName: iconName)
            await loadLists()
        } catch {
            print("Error creating list: \(error)")
        }
    }

    func deleteList(_ list: TaskList) async {
        do {
            try await repository.delete(list)
            await loadLists()
        } catch {
            print("Error deleting list: \(error)")
        }
    }
}
