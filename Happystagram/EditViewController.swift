//
//  EditViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/27.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import Firebase

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
    
    // MARK: - アプリケーションロジック
    func postAll() {
        let databaseRef = Database.database().reference()
        
        // ユーザー名
        let username = myProfileLabel.text
        // コメント
        let message = commentTextView.text
        // 投稿画像
        var data = NSData()
        if let image = imageView.image {
            data = UIImageJPEGRepresentation(image, 0.1)! as NSData
        }
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) as String
        
        // profile画像
        var data2 = NSData()
        if let image2 = myProfileImageView.image {
            data2 = UIImageJPEGRepresentation(image2, 0.1)! as NSData
        }
        let base64String2 = data2.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) as String
        
        // サーバーへ送る用Dictionary
        let user: NSDictionary = ["username":username, "comment":message, "postImage":base64String, "profileImage":base64String2]
        databaseRef.child("Posts").childByAutoId().setValue(user)
        
        // 戻る
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    // MARK: - IBAction
    
    @IBAction func post(_ sender: UIBarButtonItem) {
        postAll()
    }
    
}
