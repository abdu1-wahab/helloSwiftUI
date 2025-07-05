import SwiftUI

struct HomeVC: View {
    @StateObject private var listViewModel = TaskListViewModel(repository: TaskListRepository())
    @StateObject private var taskViewModel = TaskViewModel(repository: TaskRepository())

    @State private var navigationPath: [Route] = []
    @State private var isShowingAddTask = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    // Top Bar
                    HStack {
                        Spacer()
                        Text("To Do List")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            navigationPath.append(.settings)
                        } label: {
                            Image("img_settings_icon")
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 20)

                    // Search Bar
                    Image("search_Bar")

                    // Dashboard Cards
                    DashboardGridView(
                        allTasks: taskViewModel.allCount,
                        today: taskViewModel.todayCount,
                        completed: taskViewModel.completedCount,
                        upcoming: taskViewModel.upcomingCount
                    )
                    .padding(.horizontal)

                    // List Header
                    HStack {
                        Text("To Do List")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            // Add new list action
                        } label: {
                            HStack(spacing: 2) {
                                Image("img_add_icon")
                                Text("New List")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "#3B82F6"))
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)

                    // List View from Core Data
                    TaskListSectionView(lists: listViewModel.lists) { selectedList in
                        navigationPath.append(.taskDetail(selectedList))
                    }
                    .listStyle(.plain)

                    Spacer()

                    // Bottom New Task Button
                    HStack {
                        Button {
                            isShowingAddTask = true
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
                        }
                    }
                    .frame(height: 64)
                    //.background(Color(hex: "#1B1B1D"))
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .settings:
                    SettingsVC()
                case .taskDetail(let list):
                    TasksVC(taskList: list)
                }
            }
            .task {
                await listViewModel.loadLists()
                await taskViewModel.loadDashboardCounts()
            }
            .fullScreenCover(isPresented: $isShowingAddTask) {
                AddNewTaskVC(
                    listViewModel: listViewModel,
                    taskViewModel: taskViewModel
                )
            }
        }
    }
}


#Preview {
    HomeVC()
}
