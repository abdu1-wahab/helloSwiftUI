import SwiftUI

struct GridToDoCardItemView: View {
    let title: String
    let imageName: String
    let count: Int
    let backgroundColor: Color

    var body: some View {
        VStack {
            Image(imageName)
                .padding(.bottom, 3)
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            Text("\(count) tasks")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .padding(.top, 2)
        }
        .frame(width: 160, height: 120)
        .background(backgroundColor)
        .cornerRadius(12)
    }
}


#Preview {
    GridToDoCardItemView(title: "Completed", imageName: "img_calender", count: 3, backgroundColor: Color(hex: "#1B1B1D"))
}
