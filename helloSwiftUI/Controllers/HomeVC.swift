import SwiftUI

struct HomeVC: View {
    @StateObject private var listViewModel = TaskListViewModel(repository: TaskListRepository())
    @StateObject private var taskViewModel = TaskViewModel(repository: TaskRepository())

    @State private var navigationPath: [Route] = []
    @State private var isShowingAddTask = false
    @State private var isShowingAddList = false
    
    @State private var isSearching = false
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    searchBar

                    if isSearching {
                        // ✅ Break up the expression — compute filteredTasks first
                        let filteredTasks = taskViewModel.tasks.filter { task in
                            searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText)
                        }

                        List(filteredTasks, id: \.id) { task in
                            HStack {
                                Text(task.title)
                                    .foregroundColor(.white)
                                Spacer()
                                if task.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                    } else {
                        mainContent
                    }
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
                AddNewTaskVC(listViewModel: listViewModel, taskViewModel: taskViewModel)
            }
            .fullScreenCover(isPresented: $isShowingAddList) {
                AddNewListVC(listViewModel: listViewModel)
            }
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search tasks", text: $searchText, onEditingChanged: { editing in
                    withAnimation {
                        isSearching = editing
                    }
                })
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.white)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
            .padding(8)
            .background(Color(hex: "#1E1E1E"))
            .cornerRadius(10)
            .animation(.easeInOut, value: isSearching)

            if isSearching {
                Button("Cancel") {
                    withAnimation {
                        isSearching = false
                        searchText = ""
                        // Dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                .foregroundColor(.blue)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .animation(.easeInOut, value: isSearching)
    }


    // MARK: - Main Content
    private var mainContent: some View {
        VStack {
            NavigationView {
                DashboardGridView(
                    allTasks: taskViewModel.allCount,
                    today: taskViewModel.todayCount,
                    completed: taskViewModel.completedCount,
                    upcoming: taskViewModel.upcomingCount,
                    taskViewModel: taskViewModel
                )
            }
            .background(Color.black.ignoresSafeArea())
            .padding(.horizontal)

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

            TaskListSectionView(lists: listViewModel.lists) { selectedList in
                navigationPath.append(.taskDetail(selectedList))
            }
            .listStyle(.plain)

            Spacer()

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
        }
    }
}

#Preview {
    HomeVC()
}
