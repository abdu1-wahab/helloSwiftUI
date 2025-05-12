import Foundation


struct Onboarding_Data: Identifiable, Hashable, Equatable {
    let id = UUID()
    var title: String
    var isSelected: Bool = false

    static func == (lhs: Onboarding_Data, rhs: Onboarding_Data) -> Bool {
        lhs.id == rhs.id
    }
}
