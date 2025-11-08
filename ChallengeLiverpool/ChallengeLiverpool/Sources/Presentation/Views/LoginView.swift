//
//  LoginView.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Iniciar Sesión")
                .font(.largeTitle).bold()

            TextField("Correo electrónico", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Entrar") {
                viewModel.login()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            NavigationLink("¿No tienes cuenta? Regístrate", destination: RegisterView(viewModel: viewModel))
        }
        .padding()
    }
}
