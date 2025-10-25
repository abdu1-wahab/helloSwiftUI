import SwiftUI

struct OnboardingVC: View {
    
    
    @State private var showMainApp = false
    
    var isButtonDisabled: Bool {
        return true
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("ob_photo")
                    .aspectRatio(contentMode: .fit)
                
                Text("Task Management & To-Do List")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .padding(.horizontal, 80)
                
                Text("This productive tool is designed to help you\nbetter manage your task project-wise conveniently!")
                    .font(.system(size: 16))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 32)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 47)
                
                
                
                Button(action: {
                    showMainApp = true
                }) {
                    HStack(spacing: 12) {
                        Spacer()
                        Text("Let’s Start")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                        Spacer()
                        Image("ob_arrow")
                            .padding(.trailing, 14)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color(hex: "3B82F6"))
                    .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 47)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fullScreenCover(isPresented: $showMainApp) {
                NavigationStack {
                    HomeVC()
                }
            }
        }
    }
}

#Preview {
    OnboardingVC()
}
