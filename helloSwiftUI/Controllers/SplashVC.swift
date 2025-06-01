import SwiftUI
import Lottie

struct SplashVC: View {
    @State private var showOnboarding = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            if showOnboarding {
                OnboardingVC()
                    .transition(.opacity)
            } else {
                VStack {
                    Spacer()
                    LottieView(animation: .named("to_do"))
                        .playing(loopMode: .playOnce)
                        .animationDidFinish { completed in
                            withAnimation {
                                showOnboarding = true
                            }
                        }
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    SplashVC()
}

