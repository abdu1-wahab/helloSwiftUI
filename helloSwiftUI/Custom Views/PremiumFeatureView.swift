//
//  PremiumFeatureView.swift
//  helloSwiftUI
//
//  Created by Abdul Wahab on 04/09/2025.
//

import SwiftUI

struct FeatureRow: View {
    let image: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "9CA3AF"))
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
    }
}



struct PricingOptionButton: View {
    let option: PricingOption
    @Binding var selectedOption: String
    
    var body: some View {
        Button(action: {
            selectedOption = option.title
        }) {
            VStack(alignment: .leading) {
                HStack {
                    (
                        Text(option.title + "\n")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        +
                        Text(option.subtitle)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                    )
                    
                    Spacer()
                    
                    (
                        Text(option.price + "\n")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        +
                        Text(option.timeDuration)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                    )
                }
                
                if option.popularOnGoingOffer {
                    HStack {
                        (
                            Text(option.originalPrice)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .strikethrough(true, color: .gray)
                            +
                            Text(option.discountedPrice)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(hex: "#4ADE80"))
                        )
                    }
                }
                
            }
            .padding(27)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedOption == option.title ? Color(hex: "#12192C") : Color(hex: "#212936"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedOption == option.title ? Color(hex: "#3B82F6") : Color(hex: "#374151"), lineWidth: 2)
            )
            .overlay(
                Group {
                    if option.popularOnGoingOffer {
                        Text("Most Popular")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background((Color(hex: "#3B82F6")))
                            .clipShape(Capsule())
                            .offset(y: -20)
                    }
                },
                alignment: .top
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    let option: PricingOption =
            PricingOption(title: "Monthly",
                          subtitle: "Perfect for trying out",
                          price: "$4.99 ", timeDuration: "/month", popularOnGoingOffer: true, originalPrice: "$59.88", discountedPrice: "  Save $24")
    PricingOptionButton(option: option , selectedOption: .constant(""))
}
