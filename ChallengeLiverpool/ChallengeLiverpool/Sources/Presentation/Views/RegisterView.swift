//
//  RegisterView.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Crear cuenta")
                .font(.largeTitle).bold()

            TextField("Nombre de usuario", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Correo electrónico", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Registrarse") {
                viewModel.register()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
        }
        .padding()
    }
}
