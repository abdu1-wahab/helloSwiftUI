import SwiftUI

struct TasksVC: View {
    
    let taskList: TaskList

    @StateObject private var viewModel = TaskViewModel(repository: TaskRepository())
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(hex: "7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color(hex: "#1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }

                    Spacer()

                    Text(taskList.name)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()

                    // Spacer to balance layout
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(.horizontal, 8)
                .padding(.top, 20)

                Spacer()

                // Tasks list or empty view
                if viewModel.tasks.isEmpty {
                    NoTasksFoundView()
                } else {
                    List {
                        ForEach(filteredTasks, id: \.self) { task in
                            TaskDetailCell(task: task) {
                                Task {
                                    await viewModel.toggleTask(task)
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let task = filteredTasks[index]
                                Task {
                                    await viewModel.deleteTask(task)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $searchText)
                    .background(Color.black)
                }

                Spacer()

                // Bottom New Task Button
                HStack {
                    Spacer()
                    Button {
                        // trigger add task screen if needed
                    } label: {
                        HStack(spacing: 8) {
                            Image("img_add_icon_white")
                            Text("New Task")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadTasks(for: taskList)
        }
    }
    
    private var filteredTasks: [TaskItem] {
        if searchText.isEmpty {
            return viewModel.tasks
        } else {
            return viewModel.tasks.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let taskToDelete = viewModel.tasks[index]
                try? await viewModel.deleteTask(taskToDelete)
            }
        }
    }

}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}


#Preview {
    let context = CoreDataManager.shared.context
    let mockList = TaskList(context: context)
    mockList.name = "Mock List"
    mockList.id = UUID()
    mockList.createdAt = Date()
    mockList.iconName = "checkmark"

    return TasksVC(taskList: mockList)
}
