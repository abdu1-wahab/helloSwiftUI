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
        .init(title: "Review goals before", isSelected: false),
    ]

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
                    .padding(.horizontal, 35)

                Spacer()
                Spacer()
                Spacer()

                HFlow(itemSpacing: 12, rowSpacing: 16) {
                    ForEach($items) { $item in
                        ob_table_view(item: $item)
                            .onTapGesture {
                                item.isSelected.toggle()
                                print("Updated items after toggle: ", items.map { "\($0.title): \($0.isSelected)" })
                            }
                    }
                }
                .padding(.horizontal)

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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    OnboardingScreen()
}
