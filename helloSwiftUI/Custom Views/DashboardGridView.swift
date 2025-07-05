import SwiftUI

struct DashboardGridView: View {
    let allTasks: Int
    let today: Int
    let completed: Int
    let upcoming: Int

    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(120)), GridItem(.fixed(120))], spacing: 8) {
            
            // All Tasks
            NavigationLink(destination: CalenderVC()) {
                GridToDoCardItemView(
                    title: "All Tasks",
                    imageName: "img_allTasks",
                    count: allTasks,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            // Today
            NavigationLink(destination: CalenderVC()) {
                GridToDoCardItemView(
                    title: "Today",
                    imageName: "img_today_tasks",
                    count: today,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            // Completed
            NavigationLink(destination: CalenderVC()) {
                GridToDoCardItemView(
                    title: "Completed",
                    imageName: "img_completed_tasks",
                    count: completed,
                    backgroundColor: Color(hex: "#1B1B1D")
                )
            }

            // Upcoming
            NavigationLink(destination: CalenderVC()) {
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
    DashboardGridView(allTasks: 5, today: 3, completed: 2, upcoming: 2)
}
