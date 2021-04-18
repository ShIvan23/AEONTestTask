//
//  UIViewController+Extensions.swift
//  AEONTestTask
//
//  Created by Ivan on 18.04.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert() {
        let alertTitle = "Попробуйте еще раз"
        let alertMessage = "Введен неверный логин или пароль"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
