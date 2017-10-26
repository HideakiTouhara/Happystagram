//
//  SettingViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/26.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //backImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // アプリケーションロジック
    
    func openCamera() {
        let sourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func openPhoto() {
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let photoPicker = UIImagePickerController()
            photoPicker.sourceType = sourceType
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func changeProfile(_ sender: UIButton) {
        
        let alertViewController = UIAlertController(title: "選択してください。", message: "", preferredStyle: .actionSheet)
        alertViewController.addAction(UIAlertAction(title: "カメラ", style: .default, handler: { (action: UIAlertAction!) -> Void in
            self.openCamera()
            
        }))
        alertViewController.addAction(UIAlertAction(title: "アルバム", style: .default, handler: { (action: UIAlertAction!) -> Void in
            self.openPhoto()
            
        }))
        alertViewController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIButton) {
    }


}
