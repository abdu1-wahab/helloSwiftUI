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
