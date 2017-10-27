//
//  EditViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/27.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var myProfileLabel: UILabel!
    
    var willEditImage = UIImage()
    var userNameString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = willEditImage
        myProfileImageView.layer.cornerRadius = 8.0
        myProfileImageView.clipsToBounds = true
        commentTextView.delegate = self
        
        if UserDefaults.standard.object(forKey: "profileImage") != nil {
            let decodeData = UserDefaults.standard.object(forKey: "profileImage")
            let decodedData = NSData(base64Encoded: decodeData as! String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            let decodedImage = UIImage(data: decodedData! as Data)
            myProfileImageView.image = decodedImage
            userNameString = UserDefaults.standard.object(forKey: "userName") as! String
            myProfileLabel.text = userNameString
        } else {
            myProfileImageView.image = UIImage(named: "logo.png")
            myProfileLabel.text = "匿名"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
