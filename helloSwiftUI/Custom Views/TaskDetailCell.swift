import SwiftUI

struct TaskDetailCell: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("New Task")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("9:00 AM")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "7C7C7C"))
                    .padding(4)
                    .background(Color(hex: "E5E7EB"))
                    .cornerRadius(6)
            }
            .padding(15)
            
            HStack {
                Text("Create wireframes for the new onboarding.")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "D9D9D9"))
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack {
                HStack {
                    Image("calender_icon")
                    Text("2025-05-18")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "7C7C7C"))
                }
                
                HStack {
                    Image("time_icon")
                    Text("10:00 AM")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "7C7C7C"))
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom,30)
            
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#1B1B1D"))
        .cornerRadius(12)
    }
}

#Preview {
    TaskDetailCell()
}
