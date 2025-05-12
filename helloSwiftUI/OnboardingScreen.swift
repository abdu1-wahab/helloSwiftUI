import SwiftUI
import Flow

struct OnboardingScreen: View {
    @State private var items: [Onboarding_Data] = [
        Onboarding_Data(title: "Exercise"),
        Onboarding_Data(title: "Read Books"),
        Onboarding_Data(title: "Meditate"),
        Onboarding_Data(title: "Plan Meals"),
        Onboarding_Data(title: "Water Plants"),
        Onboarding_Data(title: "Journal"),
        Onboarding_Data(title: "Stretch for 15 minutes"),
        Onboarding_Data(title: "Review goals before"),
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
                    ForEach(items) { item in
                        ob_table_view(item: item)
                            .onTapGesture {
                                if let idx = items.firstIndex(of: item) {
                                    items[idx].isSelected.toggle()
                                }
                            }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

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
