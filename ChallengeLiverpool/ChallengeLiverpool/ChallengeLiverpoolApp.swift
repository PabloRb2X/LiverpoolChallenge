//
//  ChallengeLiverpoolApp.swift
//  ChallengeLiverpool
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ChallengeLiverpoolApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            let authRepository = AuthRepositoryImpl()
            
            let viewModel = AuthViewModel(
                loginUseCase: LoginUseCase(repository: authRepository),
                registerUseCase: RegisterUseCase(repository: authRepository),
                logoutUseCase: LogoutUseCase(repository: authRepository)
            )
            
            RootView(viewModel: viewModel)
        }
    }
}
