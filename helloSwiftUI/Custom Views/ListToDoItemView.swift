import SwiftUI

struct ListToDoItemView: View {
    @Binding var item: TO_DO_Data
    var body: some View {
            HStack {
                Image(item.imageName)
                    .padding(.leading)
                Text(item.title)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                Spacer()
                
                Text("\(item.total_tasks)")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "B9B9C3"))
                    .padding(.trailing)
                
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(item.bg_clr)
            .cornerRadius(12)
        }
}

#Preview {
    ListToDoItemView(item: .constant(TO_DO_Data(title: "All Tasks", imageName: "study_icon", bg_clr: Color(hex: "#1B1B1D"), total_tasks: 80000)))
}
