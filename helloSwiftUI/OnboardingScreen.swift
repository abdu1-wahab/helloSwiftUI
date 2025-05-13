import SwiftUI
import Flow

struct OnboardingScreen: View {
    
    @State private var items: [Onboarding_Data] = [
        .init(title: "Exercise", isSelected: false),
        .init(title: "Read Books", isSelected: false),
        .init(title: "Meditate", isSelected: false),
        .init(title: "Plan Meals", isSelected: false),
        .init(title: "Water Plants", isSelected: false),
        .init(title: "Journal", isSelected: false),
        .init(title: "Stretch for 15 minutes", isSelected: false),
        .init(title: "Review goals before bedtime", isSelected: false),
    ]

    
    var isButtonDisabled: Bool {
        !items.contains(where: { $0.isSelected })
    }
    
    var body: some View {
        ZStack {
            Image("onboarding_bg")
                .resizable()
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Pick some new habits to get started")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .padding(.leading, 2)

                Spacer()
                Spacer()
                Spacer()
                Text("Recommended")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    
                
                HFlow(itemSpacing: 12, rowSpacing: 13) {
                    ForEach($items) { $item in
                        ob_table_view(item: $item)
                            .onTapGesture {
                                item.isSelected.toggle()
                            }
                    }
                }
                .padding(.bottom, 20)
                
                

                Button(action: {
                    print("Button tapped")
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("393433"))
                        .cornerRadius(12)
                        .padding(.horizontal, 28)
                }
                .disabled(isButtonDisabled)
                .opacity(isButtonDisabled ? 0.7 : 1.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    OnboardingScreen()
}
