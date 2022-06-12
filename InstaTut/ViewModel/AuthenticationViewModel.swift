//
//  AuthenticationViewModel.swift
//  InstaTut
//
//  Created by kamil on 10/06/2022.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool {get}
    var buttonbackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

protocol FormViewModel {
    func updateForm()
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isValidEmail == true
            && password?.isEmpty == false
    }
    
    var buttonbackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.05853365928, green: 0.6500727359, blue: 0.9004906807, alpha: 1) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.7)
    }
    
    
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var photoImage: UIImage?
    
    var formIsValid: Bool {
        return email?.isValidEmail == true
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
            && photoImage != nil
    }
    
    var buttonbackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.05853365928, green: 0.6500727359, blue: 0.9004906807, alpha: 1) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.7)
    }
}
