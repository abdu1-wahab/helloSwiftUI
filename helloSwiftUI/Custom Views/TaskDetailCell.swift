import SwiftUI

struct TaskDetailCell: View {
    
    let task: TaskItem
    let changeStatus: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: changeStatus) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "25C685"))
                }
                Text(task.title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                if let time = task.dueTime {
                    Text(formattedTime(time))
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "7C7C7C"))
                        .padding(4)
                        .background(Color(hex: "343434"))
                        .cornerRadius(6)
                }
            }
            .padding(15)
            
            HStack {
                if let desc = task.taskDescription, !desc.isEmpty {
                    Text(desc)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "D9D9D9"))
                }
                
            }
            .padding(.leading)
            
            HStack(spacing: 16) {
                if let dueDate = task.dueDate {
                    Label(formattedDate(dueDate), image: "calender_icon")
                }

                if let time = task.dueTime {
                    Label(formattedTime(time), image: "time_icon")
                }

                Spacer()
            }
            .font(.system(size: 12))
            .foregroundColor(Color(hex: "7C7C7C"))
            .padding(.leading, 40)
            .padding(.bottom,30)
            
        }
        .background(Color(hex: "#1B1B1D"))
        .cornerRadius(12)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
}

private extension Label where Title == Text, Icon == Image {
    init(_ text: String, image: String) {
        self.init {
            Text(text)
        } icon: {
            Image(image)
        }
    }
}

struct TaskDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataManager.shared.context
        let task = TaskItem(context: context)
        task.id = UUID()
        task.title = "New Task"
        task.taskDescription = "Create wireframes for the new onboarding."
        task.dueDate = Date()
        task.dueTime = Date()
        task.isCompleted = true

        return TaskDetailCell(task: task) {
            print("Toggle tapped")
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.black)
    }
}
