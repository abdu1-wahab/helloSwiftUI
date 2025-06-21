import Foundation
import SwiftUI

struct ResizableGridCell: View {
    @Binding var item: Onboarding_Data

    var body: some View {
        Text(item.title)
            .font(.system(size: 15, weight: .medium))
            .lineLimit(1)
            .truncationMode(.tail)
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 14)
            .padding(.vertical, 15)
            .background(Color.black.opacity(item.isSelected ? 0.9 : 0.05))
            .foregroundColor(item.isSelected ? .white : .black)
            .cornerRadius(12)
            .fixedSize(horizontal: true, vertical: false)
    }
    
}

#Preview {
    ResizableGridCell(item: .constant(Onboarding_Data(title: "Stretch for 15 minutes", isSelected: false)))
}
