import SwiftUI
import Lottie

struct SplashVC: View {
    @State private var isFirstLaunch = false
    @State private var showNextScreen = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            if showNextScreen {
                if isFirstLaunch {
                    OnboardingVC()
                        .transition(.opacity)
                } else {
                    HomeVC()
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
            TaskListEntry(name: "ToDo", icon: "tick_icon"),
            TaskListEntry(name: "Shopping", icon: "shopping_icon"),
            TaskListEntry(name: "Work", icon: "work_icon"),
            TaskListEntry(name: "Study", icon: "study_icon")
        ]

        for entry in defaultNames {
            let list = TaskList(context: context)
            list.id = UUID()
            list.name = entry.name
            list.iconName = entry.icon
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

