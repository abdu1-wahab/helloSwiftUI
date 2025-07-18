import SwiftUI

struct SettingsVC: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                
                // top bar
                HStack {
                    Button(action: {
                        dismiss()
                    })  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(hex: "7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color(hex: "#1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    Text("Setting")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(.vertical, 10)
                
                // appearence setting
                VStack {
                    HStack {
                        Image("image_dark_appearence")
                        Text("Appearance")
                            .font(.system(size: 14))
                            .fontWeight(.regular    )
                            .foregroundColor(Color(hex: "7E7E7E"))
                        
                        Spacer()
                    }
                    
                    Color(hex: "262628")
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    
                    HStack {
                        Button(action: {
                            themeManager.currentTheme = .light
                        }) {
                            VStack {
                                Image("img_light_mode_mobile")
                                Text("Light Mode")
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(
                                        themeManager.currentTheme == .light
                                        ? Color(hex: "3B82F6")
                                        : Color(hex: "7E7E7E")
                                    )
                            }
                        }
                        .padding()
                        .padding(.horizontal, 10)
                        Button(action: {
                            themeManager.currentTheme = .dark
                        }) {
                            VStack {
                                Image("img_dark_mode_mobile")
                                Text("Dark Mode")
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(
                                        themeManager.currentTheme == .dark
                                        ? Color(hex: "3B82F6")
                                        : Color(hex: "7E7E7E")
                                    )
                                
                            }
                        }
                        .padding(10)
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(Color(hex: "1B1B1D"))
                .cornerRadius(12)
                
                // remaining settings
                List {
                    ForEach($viewModel.items) { $item in
                        SettingsRowView(item: $item)
                            .padding(.bottom, 16)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .background(Color.black.ignoresSafeArea())
                .padding(.top, 20)
                .scrollIndicators(.hidden)
                
            }
            .padding(.horizontal, 10)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsVC()
        .environmentObject(ThemeManager())
}
