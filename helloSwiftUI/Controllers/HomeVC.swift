import SwiftUI

struct HomeVC: View {
    
    let rows = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    @State private var items: [TO_DO_Data] = [
        .init(title: "All Tasks", imageName: "img_allTasks", bg_clr: Color("1B1B1D"), total_tasks: 12),
        .init(title: "Today", imageName: "img_today_tasks", bg_clr: Color("1B1B1D"), total_tasks: 4),
        .init(title: "Calendar", imageName: "img_calender", bg_clr: Color("1B1B1D"), total_tasks: 8),
        .init(title: "Completed", imageName: "img_completed_tasks", bg_clr: Color("1B1B1D"), total_tasks: 7)
    ]
    
    @State private var toDOItems: [TO_DO_Data] = [
        .init(title: "ToDo", imageName: "tick_icon", bg_clr: Color("1B1B1D"), total_tasks: 12),
        .init(title: "Shopping", imageName: "shopping_icon", bg_clr: Color("1B1B1D"), total_tasks: 12),
        .init(title: "Work", imageName: "work_icon", bg_clr: Color("1B1B1D"), total_tasks: 12),
        .init(title: "Study", imageName: "study_icon", bg_clr: Color("1B1B1D"), total_tasks: 12)
    ]
    
    // This will track navigation path
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    // top bar
                    HStack {
                        Spacer()
                        ZStack {
                            Text("To Do List")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {
                            print("Setting Button Tapped")
                        }) {
                            Image("img_settings_icon")
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 20)
                    
                    // search bar
                    Image("search_Bar")
                    
                    // top cards
                    LazyHGrid(rows: rows, spacing: 8) {
                        ForEach($items) { $item in
                            GridToDoCardItemView(item: $item)
                        }
                    }
                    
                    // total Lists View
                    HStack {
                        Text("To Do List")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            print("Setting Button Tapped")
                        }) {
                            HStack(spacing: 2) {
                                Image("img_add_icon")
                                Text("New List")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("3B82F6"))
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    // new lists as buttons (no arrow)
                    List {
                        ForEach(toDOItems.indices, id: \.self) { index in
                            Button {
                                // push the selected item on the navigation stack
                                navigationPath.append(toDOItems[index])
                            } label: {
                                ListToDoItemView(item: $toDOItems[index])
                            }
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 10)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .buttonStyle(PlainButtonStyle()) // prevent button styling
                        }
                    }
                    .listStyle(.plain)
                    .padding(.horizontal)
                    .frame(minHeight: 281, maxHeight: 281)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Button tapped")
                            }) {
                                HStack(spacing: 8) {
                                    Image("img_add_icon_white")
                                    Text("New Task")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64)
                    .background(Color("1B1B1D"))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            // Destination mapping using navigationDestination modifier
            .navigationDestination(for: TO_DO_Data.self) { item in
                TasksVC()
            }
        }
    }
}


#Preview {
    HomeVC()
}
