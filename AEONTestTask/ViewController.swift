//
//  ViewController.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import UIKit



class ViewController: UIViewController {
    
    private let apiManager = AEONManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        api()
    }
    
    func api() {
        apiManager.signin(login: "", password: "") { (result) in
            switch result {
            case .success(let token):
                print(token.response.token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

  

}

