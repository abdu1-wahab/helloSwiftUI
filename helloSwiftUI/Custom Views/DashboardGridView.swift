import SwiftUI
struct DashboardGridView: View {
    let allTasks: Int
    let today: Int
    let completed: Int
    let upcoming: Int
    let taskViewModel: TaskViewModel

    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(120)), GridItem(.fixed(120))], spacing: 8) {
            
            // All Tasks
            NavigationLink(destination: TasksVC(taskList: nil, filter: .all, viewModel: taskViewModel)) {
                GridToDoCardItemView(
                    title: "All Tasks",
                    imageName: "img_allTasks",
                    count: allTasks,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            NavigationLink(destination: TasksVC(taskList: nil, filter: .today, viewModel: taskViewModel)) {
                GridToDoCardItemView(
                    title: "Today",
                    imageName: "img_today_tasks",
                    count: today,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            NavigationLink(destination: TasksVC(taskList: nil, filter: .completed, viewModel: taskViewModel)) {
                GridToDoCardItemView(
                    title: "Completed",
                    imageName: "img_completed_tasks",
                    count: completed,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            // Upcoming — stays as calendar
            NavigationLink(destination: CalenderVC(taskViewModel: taskViewModel)) {
                GridToDoCardItemView(
                    title: "Upcoming",
                    imageName: "img_calender",
                    count: upcoming,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }
        }
    }
}

#Preview {
    DashboardGridView(allTasks: 5, today: 3, completed: 2, upcoming: 2, taskViewModel: TaskViewModel(repository: TaskRepository()))
}
