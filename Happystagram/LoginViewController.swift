//
//  LoginViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/22.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewUser(_ sender: Any) {
        
        if emailTextField.text == nil || passwordTextField.text == nil {
            let alertViewController = UIAlertController(title: "エラー", message: "入力欄が空の状態です。", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertViewController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    // 新規登録成功
                    UserDefaults.standard.set("check", forKey: "check")
                    dismiss(animated: true, completion: nil)
                } else {
                    let alertViewController = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func userLogin(_ sender: Any) {
        if emailTextField.text == nil || passwordTextField.text == nil {
            let alertViewController = UIAlertController(title: "エラー", message: "入力欄が空の状態です。", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertViewController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    
                } else {
                    let alertViewController = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    

}
