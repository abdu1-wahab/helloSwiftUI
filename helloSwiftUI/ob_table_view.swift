import Foundation
import SwiftUI

struct ob_table_view: View {
    let item: Onboarding_Data

    var body: some View {
        Text(item.title)
            .font(.system(size: 15, weight: .medium))
            .lineLimit(1)
            .truncationMode(.tail)
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.black.opacity(item.isSelected ? 0.9 : 0.05))
            .foregroundColor(item.isSelected ? .white : .black)
            .cornerRadius(12)
            .fixedSize(horizontal: true, vertical: false) // 👈 KEY FIX
    }
}

#Preview {
    ob_table_view(item: Onboarding_Data(title: "Strecth for 15 minutes", isSelected: false))
}
