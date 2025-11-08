//
//  AuthViewModelTests.swift
//  ChallengeLiverpool
//
//  Created by Pablo Ramirez on 07/11/25.
//

import XCTest
import Combine
@testable import ChallengeLiverpool

final class AuthViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        // Given
        let repo = MockAuthRepository(shouldSucceed: true)
        let viewModel = AuthViewModel(
            loginUseCase: LoginUseCase(repository: repo),
            registerUseCase: RegisterUseCase(repository: repo),
            logoutUseCase: LogoutUseCase(repository: repo)
        )
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        let expectation = XCTestExpectation(description: "Login succeeds")

        // When
        viewModel.$currentUser
            .dropFirst()
            .sink { user in
                // Then
                XCTAssertNotNil(user)
                XCTAssertEqual(user?.email, "test@example.com")
                XCTAssertNil(viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.login()
        wait(for: [expectation], timeout: 1)
    }

    func testLoginFailure() {
        // Given
        let repo = MockAuthRepository(shouldSucceed: false)
        let viewModel = AuthViewModel(
            loginUseCase: LoginUseCase(repository: repo),
            registerUseCase: RegisterUseCase(repository: repo),
            logoutUseCase: LogoutUseCase(repository: repo)
        )
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        let expectation = XCTestExpectation(description: "Login fails")

        // When
        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                // Then
                XCTAssertEqual(error, "The operation couldn’t be completed. (LoginError error 1.)")
                XCTAssertNil(viewModel.currentUser)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.login()
        wait(for: [expectation], timeout: 1)
    }

    func testRegisterSuccess() {
        // Given
        let repo = MockAuthRepository(shouldSucceed: true)
        let viewModel = AuthViewModel(
            loginUseCase: LoginUseCase(repository: repo),
            registerUseCase: RegisterUseCase(repository: repo),
            logoutUseCase: LogoutUseCase(repository: repo)
        )
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.username = "TestUser"
        let expectation = XCTestExpectation(description: "Register succeeds")

        // When
        viewModel.$currentUser
            .dropFirst()
            .sink { user in
                // Then
                XCTAssertNotNil(user)
                XCTAssertNil(viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.register()
        wait(for: [expectation], timeout: 1)
    }

    func testRegisterFailure() {
        // Given
        let repo = MockAuthRepository(shouldSucceed: false)
        let viewModel = AuthViewModel(
            loginUseCase: LoginUseCase(repository: repo),
            registerUseCase: RegisterUseCase(repository: repo),
            logoutUseCase: LogoutUseCase(repository: repo)
        )
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.username = "TestUser"
        let expectation = XCTestExpectation(description: "Register fails")

        // When
        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                // Then
                XCTAssertEqual(error, "The operation couldn’t be completed. (RegisterError error 1.)")
                XCTAssertNil(viewModel.currentUser)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.register()
        wait(for: [expectation], timeout: 1)
    }

    func testLogout() {
        // Given
        let repo = MockAuthRepository(shouldSucceed: true)
        let viewModel = AuthViewModel(
            loginUseCase: LoginUseCase(repository: repo),
            registerUseCase: RegisterUseCase(repository: repo),
            logoutUseCase: LogoutUseCase(repository: repo)
        )
        viewModel.currentUser = AuthUser(id: "123", email: "test@example.com")
        let expectation = XCTestExpectation(description: "Logout clears user")

        // When
        viewModel.$currentUser
            .dropFirst()
            .sink { user in
                // Then
                XCTAssertNil(user)
                XCTAssertNil(viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.logout()
        wait(for: [expectation], timeout: 1)
    }
}
