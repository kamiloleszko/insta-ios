//
//  LoginController.swift
//  InstaTut
//
//  Created by kamil on 09/06/2022.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: UIImage(imageLiteralResourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        return CustomTextFields(placeholder: "Email")
    }()
    
    private let passwordTextField: UITextField = {
        return CustomTextFields(placeholder: "Password")
    }()
    
    private let logginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.7), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 15
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?   ", secondPart: "Sign up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?  ", secondPart: "Get help signing in.")
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
        
        // zamyka klawiature na return
        self.emailTextField.delegate = self;
        self.passwordTextField.delegate = self;
    }
    
    //zamyka klawiature na return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }

    
    // MARK: - Actions
        
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func textDidChange(sender: UITextField) {
        setUpLoginViewModel(sender: sender)
        updateForm()
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.logUserIn(email: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Fialed log user in: \(error.localizedDescription)")
                return
            }
        
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setUpLoginViewModel(sender: UITextField) {
        if (sender == emailTextField) {
            viewModel.email = sender.text
        }
        
        if (sender == passwordTextField) {
            viewModel.password = sender.text
        }
        
        
    }
        
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 32
        )
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(
            top: iconImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: 32
        )
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor
        )
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

// MARK: - FormViewModel

extension LoginController: FormViewModel {
    
    func updateForm() {
        logginButton.backgroundColor = viewModel.buttonbackgroundColor
        logginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        logginButton.isEnabled = viewModel.formIsValid
    }
}


