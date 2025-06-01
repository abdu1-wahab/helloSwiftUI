import SwiftUI

struct NoTasksFoundView: View {
    var body: some View {
        VStack {
            Image("img_no_tasks_found")
                .padding(.top,8)
            Text("No Tasks")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundColor(Color("5F6772"))
                
            Text("It seems there are no task added yet.")
                .font(.system(size: 10))
                .fontWeight(.regular)
                .foregroundColor(Color("5F6772"))
            Text("Click on the Add New Task button to create a new task.")
                .font(.system(size: 10))
                .fontWeight(.regular)
                .foregroundColor(Color("5F6772"))
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        
    }
}

#Preview {
    NoTasksFoundView()
}
