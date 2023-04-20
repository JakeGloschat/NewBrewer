//
//  SignInViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signInWithAppleButton = ASAuthorizationAppleIDButton()
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInWithAppleButton)
        NSLayoutConstraint.activate([
            signInWithAppleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signInWithAppleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        signInWithAppleButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
        viewModel = SignInAccountViewModel()
        
    }
    
    // MARK: - Function
    @objc func appleSignInTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [
            .email
        ]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.signInAccount(email: email, password: password)
    }
}
extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        <#code#>
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        <#code#>
    }
}
