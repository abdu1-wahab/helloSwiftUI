import SwiftUI

struct PricingOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let price: String
    let timeDuration: String
    let popularOnGoingOffer: Bool
    let originalPrice: String
    let discountedPrice: String
}

struct PremiumVC: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption: String = "Yearly"
    @State private var showMainApp = false
    
    let options: [PricingOption] = [
            PricingOption(title: "Monthly",
                          subtitle: "Perfect for trying out",
                          price: "$4.99 ", timeDuration: "/month", popularOnGoingOffer: false, originalPrice: "", discountedPrice: ""),
            
            PricingOption(title: "Yearly",
                          subtitle: "Save 50% with annual billing",
                          price: "$2.99", timeDuration: "/month", popularOnGoingOffer: true, originalPrice: "$59.88", discountedPrice: "  Save $24"
                         ),
            
            PricingOption(title: "Lifetime",
                          subtitle: "One-time purchase",
                          price: "$49.99", timeDuration: "forever", popularOnGoingOffer: false, originalPrice: "", discountedPrice: "")
        ]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Unlock Premium")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "C9C9CA"))
                        .padding()
                    
                    Text("Get unlimited access to all features and boost your productivity")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "9CA3AF"))
                        .padding(.horizontal, 50)
                    VStack(alignment: .leading) {
                        FeatureRow(image: "img_infinity", title: "Unlimited Tasks", subtitle: "Create and manage unlimited tasks and projects to stay organized and boost productivity.")
                        FeatureRow(image: "img_customize_theme", title: "Custom Themes", subtitle: "Personalize your experience with a variety of premium themes tailored to your style.")
                        FeatureRow(image: "img_no_ads", title: "No Ads",
                                   subtitle: "Enjoy an ad-free experience with the premium version.")
                    }
                    VStack(spacing: 16) {
                        ForEach(options) { option in
                            PricingOptionButton(option: option, selectedOption: $selectedOption)
                        }
                    }
                    .padding()
                    
                    Text("7 Days free trial")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "6B7280"))
                    
                    Button(action: {
                        showMainApp = true
                    }) {
                        Text("Start Free Trial")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hex: "3B82F6"))
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                    }
                    
                    Button(action: {
                        showMainApp = true
                    }) {
                        Text("Restore Purchase")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color(hex: "D1D5DB"))
                            .padding()
                    }
                    
                    Text("Cancel anytime.")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "6B7280"))
                 
                    HStack {
                        Text("Terms")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "6B7280"))
                        
                        Spacer()
                        
                        Text("Privacy Policy")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: "6B7280"))
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "multiply")
                        .foregroundColor(Color(hex: "C9C9CA"))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        PremiumVC()
    }
}
