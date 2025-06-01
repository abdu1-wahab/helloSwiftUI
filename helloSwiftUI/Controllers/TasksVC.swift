import SwiftUI

struct TasksVC: View {
    
    let subtiles: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    })  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color("7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color("1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }

                    Spacer()
                    
                    Text("List Name")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Empty spacer to balance the layout
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(.horizontal, 8)
                .padding(.top, 20)
                
                Spacer()
                
                if subtiles == 0 {
                    NoTasksFoundView()
                } else {
                    Text("Hello")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Bottom Button
                HStack {
                    Spacer()
                    Button(action: {
                        print("Button tapped")
                    }) {
                        HStack(spacing: 8) {
                            Image("img_add_icon_white")
                            Text("New Task")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}


#Preview {
    TasksVC()
}
