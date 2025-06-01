import Foundation
import SwiftUICore


struct Onboarding_Data: Identifiable {
    let id = UUID()
    var title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct TO_DO_Data: Identifiable, Hashable{
    let id = UUID()
    var title: String
    var imageName: String
    var bg_clr: Color
    var total_tasks: Int
    
    init(title: String, imageName: String, bg_clr: Color, total_tasks: Int) {
        self.title = title
        self.imageName = imageName
        self.bg_clr = bg_clr
        self.total_tasks = total_tasks
    }
}
