import SwiftUI

struct TaskListSectionView: View {
    @EnvironmentObject var theme: ThemeManager
    
    let lists: [TaskList]
    let onSelect: (TaskList) -> Void

    var body: some View {
        List {
            ForEach(lists, id: \.self) { list in
                Button {
                    onSelect(list)
                } label: {
                    ListToDoItemView(
                        title: list.name,
                        taskCount: list.tasks?.count ?? 0,
                        iconName: list.iconName, backgroundColor: theme.backgroundSecondary, iconColor:
                            Color(hex: list.iconColor)
                    )
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom, 10)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .padding(.horizontal)
    }
}


//#Preview {
//    TaskListSectionView(lists: [
//        {
//            let list = TaskList(context: CoreDataManager.shared.context)
//            list.name = "Work"
//            list.iconName = "briefcase"
//            list.tasks = NSSet(array: [Task(context: CoreDataManager.shared.context)])
//            return list
//        }()
//    ]) { _ in }
//}

