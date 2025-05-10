import SwiftUI
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

    let columns = [
        GridItem(.adaptive(minimum: 10), spacing: 12) // just let chips self-size
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

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items.indices, id: \.self) { index in
                        ob_table_view(item: items[index])
                            .onTapGesture {
                                withAnimation {
                                    for i in items.indices {
                                        items[i].isSelected = (i == index) ? !items[i].isSelected : false
                                    }
                                }
                            }
                    }
                }
                .padding()

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
