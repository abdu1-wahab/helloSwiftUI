import SwiftUI

struct AddNewTaskVC: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    @State var textDescription = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var endTime = Date()
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: date)
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // top bar
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
                    
                    Text("New Task")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Empty spacer to balance the layout
                    Color.clear.frame(width: 48, height: 48)
                }
                
                // new list group
                HStack {
                    Image("tick_icon")
                        .padding([.leading, .top, .bottom], 12)
                    VStack(alignment: .leading){
                        Text("Task Group")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        Text("Task Group")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top,2)
                        
                    }
                    
                    Spacer()
                    
                    Image("img_drop_down")
                        .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                
                // task title
                HStack {
                    VStack(alignment: .leading){
                        Text("Task Name")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        TextField(
                            "",
                            text: $text,
                            prompt: Text("Enter Task Name")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#7C7C7C"))
                        )
                        .lineLimit(1)
                        .submitLabel(.done)
                        .onSubmit {
                                // Dismiss keyboard or handle action
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }

                    }
                    .padding(8)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.top,.bottom], 20)
               
                // task description
                HStack {
                    VStack(alignment: .leading){
                        Text("Task Name")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "7C7C7C"))
                        
                        TextField(
                            "",
                            text: $textDescription,
                            prompt: Text("Enter Task Description")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#7C7C7C"))
                        )
                        .submitLabel(.done)
                        .onSubmit {
                                // Dismiss keyboard or handle action
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        Spacer()
                    }
                    .padding(8)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 132)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                
                // start date
                HStack {
                    HStack {
                        Image("img_new_date")
                        VStack (alignment: .leading){
                            Text("Start Date")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedDate(startDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                // End date
                HStack {
                    HStack {
                        Image("img_new_date")
                        VStack (alignment: .leading){
                            Text("Start Date")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedDate(endDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                // End Time
                HStack {
                    HStack {
                        Image("img_new_time")
                        VStack (alignment: .leading){
                            Text("Select Time")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "7C7C7C"))
                            Text(formattedDate(endDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "FFFFFF"))
                        }
                        Spacer()
                        Image("img_drop_down")
                    }
                    .padding(15)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(12)
                .padding([.bottom], 20)
                
                Spacer()
                
                Button(action: {
                    print("Button Tapped")
                }) {
                    Text("Add New Task")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(hex: "3B82F6"))
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                }

                
            }
            
        }
    }
}

#Preview {
    AddNewTaskVC()
}
