import Foundation


struct Onboarding_Data: Identifiable {
    let id = UUID()
    var title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
