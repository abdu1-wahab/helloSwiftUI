import SwiftUI

struct ListToDoItemView: View {
    let title: String
    let taskCount: Int
    let iconName: String
    let backgroundColor: Color

    var body: some View {
        HStack {
            Image(iconName)
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


//#Preview {
//    ListToDoItemView(
//        title: list.name ?? "Untitled",
//        taskCount: list.tasks?.count ?? 0,
//        iconName: list.iconName ?? "tick_icon",
//        backgroundColor: Color(hex: "#1B1B1D")
//    )
//
//}
