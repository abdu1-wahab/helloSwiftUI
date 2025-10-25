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
                Spacer()

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
        .navigationTitle("Add Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .background(Color(hex: "#1B1B1D"))
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                        .shadow(radius: 1)
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

    return  NavigationStack {
        TasksVC(taskList: mockList)
    }
}
