import SwiftUI

struct TasksVC: View {
    
    let taskList: TaskList

    @StateObject private var viewModel = TaskViewModel(repository: TaskRepository())
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

                    Text(taskList.name ?? "Tasks")
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
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewModel.tasks, id: \.self) { task in
                                HStack {
                                    Text(task.title ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    Spacer()
                                    if task.isCompleted {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(Color(hex: "#1B1B1D"))
                                .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
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
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}


//#Preview {
//    TasksVC(taskList: TaskLi)
//}
