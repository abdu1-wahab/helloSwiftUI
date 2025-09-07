import SwiftUI

struct ListToDoItemView: View {
    let title: String
    let taskCount: Int
    let iconName: String
    let backgroundColor: Color
    let iconColor: Color

    var body: some View {
        HStack {

            ZStack {
                Rectangle()
                    .fill(iconColor).opacity(0.1)
                    .frame(width: 32, height: 32)
                    .cornerRadius(6)
                
                Image(iconName)
                    .resizable()
                    .foregroundColor(iconColor)
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(.leading)
            
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.leading, 4)

            Spacer()

            Text("\(taskCount)")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color(hex: "B9B9C3"))
                .padding(.trailing)
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(12)
    }
}


#Preview {
    ListToDoItemView(
        title: "Untitled",
        taskCount:  0,
        iconName: "tick_icon",
        backgroundColor: Color(hex: "#1B1B1D"), iconColor: Color(hex: "#7D5FFF")
    )

}
