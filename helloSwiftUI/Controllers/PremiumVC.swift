import SwiftUI

struct PricingOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let price: String
    let tag: String?
}

struct PremiumVC: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption: String = "Yearly"
    @State private var showMainApp = false
    
    let options: [PricingOption] = [
            PricingOption(title: "Monthly",
                          subtitle: "Perfect for trying out",
                          price: "$4.99 /month",
                          tag: nil),
            
            PricingOption(title: "Yearly",
                          subtitle: "Save 50% with annual billing\n$59.88  Save $24",
                          price: "$2.99 /month",
                          tag: "Most Popular"),
            
            PricingOption(title: "Lifetime",
                          subtitle: "One-time purchase",
                          price: "$49.99 forever",
                          tag: nil)
        ]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Unlock Premium")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Get unlimited access to all features and boost your productivity")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "9CA3AF"))
                    
                    
                    HStack {
                        Image("img_infinity")
                        VStack(alignment: .leading) {
                            Text("Unlimited Tasks")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("Create and manage unlimited tasks and projects to stay organized and boost productivity.")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "9CA3AF"))
                        }
                    }
                    .padding()
                    
                    HStack {
                        Image("img_customize_theme")
                        VStack(alignment: .leading) {
                            Text("Custom Themes")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("Personalize your experience with a variety of premium themes tailored to your style.")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "9CA3AF"))
                        }
                    }
                    .padding()
                    
                    HStack {
                        Image("img_no_ads")
                        VStack(alignment: .leading) {
                            Text("No Ads")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("Enjoy an ad-free experience with the premium version.")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "9CA3AF"))
                        }
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        ForEach(options) { option in
                            Button(action: {
                                selectedOption = option.title
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(option.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        if let tag = option.tag {
                                            Text(tag)
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                        }
                                    }
                                    
                                    Text(option.subtitle)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Text(option.price)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedOption == option.title ? Color.blue.opacity(0.6) : Color.black.opacity(0.8))
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
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
