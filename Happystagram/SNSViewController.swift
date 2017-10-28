//
//  SNSViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/28.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import Social

class SNSViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // 投稿されている画像
    var detailImage = UIImage()
    
    // プロフィール
    var detailProfileImage = UIImage()
    var detailUserName = String()
    
    var myComposeview:SLComposeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImageView.image = detailProfileImage
        label.text = detailUserName
        imageView.image = detailImage
        
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    @IBAction func shareTwitter(_ sender: UIButton) {
        myComposeview = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキスト
        let string = "Happystagram" + " Photo by " + label.text!
        myComposeview.setInitialText(string)
        myComposeview.add(imageView.image)
        
        self.present(myComposeview, animated: true, completion: nil)
        
    }
    
    
    
}
