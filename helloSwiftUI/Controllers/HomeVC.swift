import SwiftUI

struct HomeVC: View {
    @StateObject private var listViewModel = TaskListViewModel(repository: TaskListRepository())
    @StateObject private var taskViewModel = TaskViewModel(repository: TaskRepository())

    @State private var navigationPath: [Route] = []
    @State private var isShowingAddTask = false
    @State private var isShowingAddList = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    // Search Bar
                    Image("search_Bar")

                    // Dashboard Cards
                    NavigationView {
                        DashboardGridView(
                            allTasks: taskViewModel.allCount,
                            today: taskViewModel.todayCount,
                            completed: taskViewModel.completedCount,
                            upcoming: taskViewModel.upcomingCount, taskViewModel: taskViewModel
                        )
                    }
                    .background(Color.black.ignoresSafeArea())
                    .padding(.horizontal)
                    

                    // List Header
                    HStack {
                        Text("To Do List")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            isShowingAddList = true
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
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigationPath.append(.settings)
                    } label: {
                        Image("img_settings_icon")
                    }
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
            .fullScreenCover(isPresented: $isShowingAddList) {
                AddNewListVC()
            }
        }
    }
}


#Preview {
    HomeVC()
}
