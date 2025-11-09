import SwiftUI
struct DashboardGridView: View {
    let allTasks: Int
    let today: Int
    let completed: Int
    let upcoming: Int
    let onSelectFilter: (TaskFilterType) -> Void

    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(120)), GridItem(.fixed(120))], spacing: 8) {

            GridButton(title: "All Tasks", image: "img_allTasks", count: allTasks, color: "#1B1B1D") {
                onSelectFilter(.all)
            }

            GridButton(title: "Today", image: "img_today_tasks", count: today, color: "#1B1B1D") {
                onSelectFilter(.today)
            }

            GridButton(title: "Completed", image: "img_completed_tasks", count: completed, color: "#1B1B1D") {
                onSelectFilter(.completed)
            }

            GridButton(title: "Upcoming", image: "img_calender", count: upcoming, color: "#1B1B1D") {
                onSelectFilter(.upcoming)
            }
        }
    }
}

private struct GridButton: View {
    let title: String
    let image: String
    let count: Int
    let color: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            GridToDoCardItemView(
                title: title,
                imageName: image,
                count: count,
                backgroundColor: Color(hex: color)
            )
        }
    }
}


//#Preview {
//    DashboardGridView(allTasks: 5, today: 3, completed: 2, upcoming: 2, taskViewModel: TaskViewModel(repository: TaskRepository()))
//}
