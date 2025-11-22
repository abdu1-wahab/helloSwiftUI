import SwiftUI

struct NoTasksFoundView: View {
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        VStack {
            Image("img_no_tasks_found")
                .padding(.top,8)
            Text("No Tasks")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundColor(theme.textSecondary)
                
            Text("It seems there are no task added yet.")
                .font(.system(size: 10))
                .fontWeight(.regular)
                .foregroundColor(theme.textSecondary)
            Text("Click on the Add New Task button to create a new task.")
                .font(.system(size: 10))
                .fontWeight(.regular)
                .foregroundColor(theme.textSecondary)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.backgroundPrimary)
        
    }
}

#Preview {
    NoTasksFoundView()
}
