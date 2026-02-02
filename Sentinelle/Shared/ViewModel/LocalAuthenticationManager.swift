//
//  LocalAuthenticationManager.swift
//  Sentinelle
//
//  Created by Sebby on 08/11/2024.
//

import Foundation
import LocalAuthentication

@MainActor
final class LocalAuthenticationManager: ObservableObject, Sendable {
    enum AuthenticationState: String, Hashable, CaseIterable, Sendable {
        case loggedOut, loggedIn
    }
    @Published var authenticationState: AuthenticationState = .loggedOut
    let context: LAContext = LAContext()
    @Published var isAuthenticated: Bool = false
    @Published var error: Error?
    @Published var showError: Bool = false
    @Published var isPresented: Bool = false
    @Published var isAuthEnabled: Bool = UserDefaults.standard.bool(forKey: "isAuthEnabled") {
        didSet {
            self.authenticate()
        }
    }
    
    
    func authenticate() {
        guard isAuthEnabled else {
            authenticationState = .loggedIn
            return
        }
        guard isAuthConfigured() else {
            authenticationState = .loggedIn
            return showError.toggle()
        }
        Task  {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Accéder à mon journal personnel !")
                DispatchQueue.main.async {
                    self.authenticationState = .loggedIn
                }
            } catch let error {
                if let error = error as? LAError {
                    switch error.code {
                    case .appCancel:
                        self.error = AuthentificationError.appCancel
                        self.showError.toggle()
                    case .biometryLockout:
                        self.error = AuthentificationError.biometricLockout
                        self.showError.toggle()
                    default:
                        self.error = AuthentificationError.uknown
                        self.showError.toggle()
                    }
                }
                // Fall back to a asking for username and password.
                // ...
            }
        }
    }
    
    func isAuthConfigured() -> Bool {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            // Fall back to a asking for username and password.
            // ...
            return false
        }
        return true
        
    }
    
    
    
}
