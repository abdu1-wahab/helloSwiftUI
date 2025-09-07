import SwiftUI

struct AddNewListVC: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    let colors: [Color] = [
        Color(hex: "#3B82F6"),  Color(hex: "#EF4444"),  Color(hex: "#22C55E"),  Color(hex: "#EAB308"),  Color(hex: "#A855F7"),  Color(hex: "#EC4899"), Color(hex: "#F97316"),  Color(hex: "#14B8A6"),  Color(hex: "#6366F1"),  Color(hex: "#6B7280"),  Color(hex: "#10B981"),  Color(hex: "#F43F5E")
    ]
    
    let iconNames = [ "img_list","img_heart", "img_star", "img_home", "img_work", "img_shopping", "img_study", "img_music", "img_camera","img_gaming","img_travel", "img_gift"]
    
    @State private var selectedColor: Color? = Color(hex: "#3B82F6")
    @State private var selectedIcon: String = "img_list"
    var isFormValid: Bool {
       return true
    }
    let colorColumns = Array(repeating: GridItem(.flexible(), spacing: 19), count: 6)
    let iconColumns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 4)
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    Button(action: {
                        dismiss()
                    })  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(hex: "7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color(hex: "#1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    Text("Create List")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(.horizontal, 15)
            
                
                Text("Choose Icons")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "#FFFFFF"))
                    .padding(.horizontal, 28)
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text("  Enter Task Name")
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
                .padding(.vertical, 9)
                
                Text("Choose Icons")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 11)
                
                
                LazyVGrid(columns: iconColumns, spacing: 12) {
                    ForEach(iconNames, id: \.self) { name in
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: "#1B1B1D"))
                                .frame(width: 79, height: 56)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedIcon == name ? Color.blue : Color.clear, lineWidth: 2)
                                )
                            
                            Image(name)
                                .resizable()
                                .foregroundColor(selectedIcon == name ?  selectedColor : .white)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            if selectedIcon == name {
                                
                            }
                        }
                        .onTapGesture {
                            selectedIcon = name
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Text("Choose Color")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 21)
                
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
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: saveTask) {
                    Text("Save")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(hex: "3B82F6"))
                        .cornerRadius(14)
                        .padding(.horizontal, 22)
                }
                .disabled(!isFormValid)
            }
            
        }
    }
    
    
    private func saveTask() {
        
    }
}

#Preview {
    return  NavigationStack {
        AddNewListVC()
    }
}
