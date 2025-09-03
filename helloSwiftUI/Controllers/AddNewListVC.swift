import SwiftUI

struct AddNewListVC: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    let colors: [Color] = [
        Color(hex: "#3B82F6"),  Color(hex: "#EF4444"),  Color(hex: "#22C55E"),  Color(hex: "#EAB308"),  Color(hex: "#A855F7"),  Color(hex: "#EC4899"), Color(hex: "#F97316"),  Color(hex: "#14B8A6"),  Color(hex: "#6366F1"),  Color(hex: "#6B7280"),  Color(hex: "#10B981"),  Color(hex: "#F43F5E")
    ]
    
    let images: [Image] = [ Image("img_list"), Image("img_heart"), Image("img_star"), Image("img_home"),
                             Image("img_work"), Image("img_shopping"), Image("img_study"), Image("img_music"),
                             Image("img_camera"), Image("img_gaming"),Image("img_travel"),Image("img_gift") ]
    
    @State private var selectedColor: Color? = Color(hex: "#3B82F6")
    @State private var selectedIcon: Image? = Image("#img_list")
    let colorColumns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 6)
    let iconColumns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("List Title")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "6B7280"))
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Enter Task Name")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .foregroundColor(Color(hex: "#7C7C7C"))
                )
                .lineLimit(1)
                .submitLabel(.done)
                .onSubmit {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding(.horizontal, 20)
            }
            
            Text("Choose Icons")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
//            LazyVGrid(columns: iconColumns, spacing: 20) {
//                ForEach(images, id: \.self) { icon in
//                    ZStack {
//                        Circle()
//                            .fill(color)
//                            .frame(width: 40, height: 40)
//                        
//                        if selectedIcon == icon {
//                            Circle()
//                                .stroke(Color.white, lineWidth: 3)
//                                .frame(width: 40, height: 40)
//                                .shadow(radius: 4)
//                            
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.white)
//                                .font(.system(size: 18, weight: .bold))
//                        }
//                    }
//                    .onTapGesture {
//                        selectedIcon = icon
//                    }
//                }
//            }
            
            
            Text("Choose Color")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            LazyVGrid(columns: colorColumns, spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                        
                        if selectedColor == color {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 40, height: 40)
                                .shadow(radius: 4)
                            
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    .onTapGesture {
                        selectedColor = color
                    }
                }
            }
            
        }
        .navigationTitle("Create List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .background(Color(hex: "#1B1B1D"))
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                        .shadow(radius: 1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    return  NavigationStack {
//        AddNewListVC()
//    }
//}
