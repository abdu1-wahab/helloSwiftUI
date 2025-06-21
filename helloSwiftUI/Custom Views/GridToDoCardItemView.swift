import SwiftUI

struct GridToDoCardItemView: View {
    
    @Binding var item: TO_DO_Data
    
    var body: some View {
            VStack {
                Image(item.imageName)
                    .padding(.bottom, 3)
                Text(item.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                Text("\(item.total_tasks) tasks")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white)
                    .padding(.top, 2)
            }
            .frame(width: 160, height: 120)
            .background(item.bg_clr)
            .cornerRadius(12)
        
    }
}

#Preview {
    GridToDoCardItemView(item: .constant(TO_DO_Data(title: "All Tasks", imageName: "img_allTasks", bg_clr: Color(hex: "393433"), total_tasks: 12)))
}
