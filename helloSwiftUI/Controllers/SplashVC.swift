import SwiftUI
import Lottie

struct SplashVC: View {
    @EnvironmentObject var theme: ThemeManager
    
    @State private var isFirstLaunch = false
    @State private var showNextScreen = false

    var body: some View {
        ZStack {
            theme.backgroundPrimary.ignoresSafeArea()

            if showNextScreen {
                if isFirstLaunch {
                    OnboardingVC()
                        .environmentObject(theme)
                        .transition(.opacity)
                } else {
                    HomeVC()
                        .environmentObject(theme)
                        .transition(.opacity)
                }
            } else {
                VStack {
                    Spacer()
                    LottieView(animation: .named("to_do"))
                        .playing(loopMode: .playOnce)
                        .animationDidFinish { _ in
                            withAnimation {
                                showNextScreen = true
                            }
                        }
                    Spacer()
                }
            }
        }
        .onAppear {
            checkFirstLaunchAndSeedData()
        }
    }

    private func checkFirstLaunchAndSeedData() {
        let key = "hasLaunchedBefore"
        let launchedBefore = UserDefaults.standard.bool(forKey: key)

        if !launchedBefore {
            isFirstLaunch = true
            UserDefaults.standard.set(true, forKey: key)

            seedDefaultListsIfNeeded()
        } else {
            isFirstLaunch = false
        }
    }

    private func seedDefaultListsIfNeeded() {
        let context = CoreDataManager.shared.context
        let hasSeededKey = "hasSeededDefaultLists"

        if UserDefaults.standard.bool(forKey: hasSeededKey) {
            return
        }

        let defaultNames: [TaskListEntry] = [
            TaskListEntry(name: "ToDo", icon: "tick_icon", iconColor: "7D5FFF"),
            TaskListEntry(name: "Shopping", icon: "img_shopping", iconColor: "FEA47F"),
            TaskListEntry(name: "Work", icon: "img_work", iconColor: "25C685"),
            TaskListEntry(name: "Study", icon: "img_study", iconColor: "FFD43B")
        ]

        for entry in defaultNames {
            let list = TaskList(context: context)
            list.id = UUID()
            list.name = entry.name
            list.iconName = entry.icon
            list.iconColor = entry.iconColor
            list.createdAt = Date()
        }

        do {
            try context.save()
            UserDefaults.standard.set(true, forKey: hasSeededKey)
            print("✅ Default lists seeded.")
        } catch {
            print("❌ Failed to seed default lists: \(error)")
        }
    }

}

#Preview {
    SplashVC()
}

