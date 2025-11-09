import SwiftUI

struct CalenderVC: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var taskViewModel: TaskViewModel
    
    var currentDate: Date {
        Calendar.current.date(byAdding: .month, value: currentMonthOffset, to: Date())!
    }

    @State private var currentMonthOffset = 0
    @State private var showMonthYearPicker = false
    @State private var selectedDate = Date()
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    
    var currentYear: Int { Calendar.current.component(.year, from: Date()) }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                // Calendar View
                VStack {
                    HStack {
                        Button(action: swipeToPreviousMonth) {
                            Image("calender_backward_img")
                        }
                        
                        Spacer()
                        
                        Text(currentDate.formatted(.dateTime.month().year()))
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .onTapGesture {
                                withAnimation {
                                    showMonthYearPicker = true
                                }
                            }
                        
                        Spacer()
                        
                        Button(action: swipeToNextMonth) {
                            Image("calender_forward_img")
                        }
                    }
                    .padding(.top, 20)
                    
                    HStack {
                        ForEach(Date.capitalizedShortWeekdays, id: \.self) { day in
                            Text(day)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    TabView(selection: $currentMonthOffset) {
                        ForEach(-120...120, id: \.self) { offset in
                            CalendarGridView(
                                referenceDate: Calendar.current.date(byAdding: .month, value: offset, to: Date())!,
                                selectedDate: $selectedDate,
                                taskSummaries: taskViewModel.taskDaySummaries
                            )
                            .tag(offset)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 250)
                }
                .padding(.horizontal, 10)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(16)
                
                HStack {
                    Text(selectedDate.formattedDateWithWeekDay)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    Image("tasks_status_img")
                    Text("\(taskViewModel.tasksForSelectedDate.count) tasks")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.top, 8)
                
                List(taskViewModel.tasksForSelectedDate, id: \.id) { task in
                    TasksStatusView(
                        title: task.title,
                        startDate: task.createdAt,
                        endDate: task.dueTime ?? Date(),
                        isCompleted: task.isCompleted
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                
                Spacer()
            }
        }
        .navigationTitle("Calendar")
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
                              .padding(10)
                              .background(Color(hex: "#1B1B1D"))
                              .clipShape(Circle())
                              .shadow(radius: 1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await taskViewModel.loadTaskSummaries(for: currentDate)
                await taskViewModel.loadTasks(for: selectedDate)
            }
        }
        .onChange(of: currentMonthOffset) {
            Task {
                await taskViewModel.loadTaskSummaries(for: currentDate)
            }
        }
        .onChange(of: selectedDate) { _, newDate in
            Task {
                await taskViewModel.loadTasks(for: newDate)
            }
        }
    }
    
    private func swipeToNextMonth() {
        if currentMonthOffset < 120 {
            currentMonthOffset += 1
        }
    }

    private func swipeToPreviousMonth() {
        if currentMonthOffset > -120 {
            currentMonthOffset -= 1
        }
    }
}

#Preview {
    NavigationStack {
        CalenderVC(taskViewModel: TaskViewModel(repository: TaskRepository()))
    }
}
