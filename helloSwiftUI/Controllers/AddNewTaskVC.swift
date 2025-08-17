import SwiftUI
import Foundation
import SSDateTimePicker

struct AddNewTaskVC: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    @State var textDescription = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var endTime = Date()
    
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    @State private var showTimePicker = false
    @State private var showInvalidDateAlert = false

    var isFormValid: Bool {
        selectedGroup != nil && !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    @State private var selectedGroup:TaskList?
    @State private var isPickerPresented = false
    
    @ObservedObject var listViewModel: TaskListViewModel
    @ObservedObject var taskViewModel: TaskViewModel
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: date)
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // top bar
                HStack {
                    Button(action: {
                        dismiss()
                    })  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(hex: "7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color(hex: "#1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    Text("New Task")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(3)
                
                // new list group
                HStack {
                    Image("tick_icon")
                        .padding([.leading, .top, .bottom], 12)
                    VStack(alignment: .leading){
                        Text("Task Group")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        Picker("Select Group", selection: $selectedGroup) {
                            ForEach(listViewModel.lists, id: \.self) { list in
                                Text(list.name).tag(Optional(list))
                            }
                        }
                        .pickerStyle(.menu)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(height: 20)
                        .tint(.white)

                    }
                    
                    Spacer()
                    
                    Image("img_drop_down")
                        .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                
                // task title
                HStack {
                    VStack(alignment: .leading){
                        Text("Task Name")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        TextField(
                            "",
                            text: $text,
                            prompt: Text("Enter Task Name")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#7C7C7C"))
                        )
                        .lineLimit(1)
                        .submitLabel(.done)
                        .onSubmit {
                            // Dismiss keyboard or handle action
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                    }
                    .padding(8)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.top,.bottom], 20)
                
                // task description
                HStack {
                    VStack(alignment: .leading){
                        Text("Task Name")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        TextField(
                            "",
                            text: $textDescription,
                            prompt: Text("Enter Task Description")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#7C7C7C"))
                        )
                        .submitLabel(.done)
                        .onSubmit {
                            // Dismiss keyboard or handle action
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        Spacer()
                    }
                    .padding(8)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 132)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                
                // start date
                HStack {
                    HStack {
                        Image("img_new_date")
                        VStack (alignment: .leading){
                            Text("Start Date")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedDate(startDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    .onTapGesture {
                        showStartDatePicker = true
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                // End date
                HStack {
                    HStack {
                        Image("img_new_date")
                        VStack (alignment: .leading){
                            Text("Start Date")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedDate(endDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    .onTapGesture {
                        showEndDatePicker = true
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                // End Time
                HStack {
                    HStack {
                        Image("img_new_time")
                        VStack (alignment: .leading){
                            Text("Select Time")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedTime(endTime))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    .onTapGesture {
                        showTimePicker = true
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                Spacer()
                
                Button(action: saveTask) {
                    Text("Add New Task")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(hex: "3B82F6"))
                        .cornerRadius(14)
                        .padding(.horizontal, 22)
                }
                .disabled(!isFormValid)
            }
            .padding(.horizontal, 5)
            
            .alert("Invalid End Date", isPresented: $showInvalidDateAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("End date can't be earlier than the start date.")
            }
            SSDatePicker(showDatePicker: $showStartDatePicker)
                .selectedDate(startDate)
                .onDateSelection { newStart in
                    startDate = newStart
                    if endDate < newStart {
                        endDate = newStart
                    }
                }
            
            // 🗓 End Date Picker
            SSDatePicker(showDatePicker: $showEndDatePicker)
                .selectedDate(endDate)
                .onDateSelection { newEnd in
                    if newEnd >= startDate {
                        endDate = newEnd
                    } else {
                        showInvalidDateAlert = true
                    }
                }
            
            // ⏰ Time Picker
            SSTimePicker(showTimePicker: $showTimePicker)
                .selectedTime(endTime)
                .onTimeSelection { time in
                    endTime = time
                }
            
        }
        .onAppear {
            if selectedGroup == nil, let firstList = listViewModel.lists.first {
                selectedGroup = firstList
            }
        }
    }
    
    private func saveTask() {
        guard let selectedList = selectedGroup else { return }

        Task {
            await taskViewModel.addTask(
                title: text,
                desc: textDescription,
                list: selectedList,
                dueDate: endDate,
                endTime: endTime
            )
            dismiss()
        }
    }


}

#Preview {
    let mockList = TaskList(context: CoreDataManager.shared.context)
    mockList.id = UUID()
    mockList.name = "Sample List"
    mockList.iconName = "star"
    mockList.createdAt = Date()
    
    let mockListVM = TaskListViewModel(repository: TaskListRepository())
    mockListVM.lists = [mockList]
    
    let mockTaskVM = TaskViewModel(repository: TaskRepository())

    return NavigationStack {
        AddNewTaskVC(
            listViewModel: mockListVM,
            taskViewModel: mockTaskVM
        )
    }
}
