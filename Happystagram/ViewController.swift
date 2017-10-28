//
//  ViewController.swift
//  Happystagram
//
//  Created by HideakiTouhara on 2017/10/22.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let refreshControl = UIRefreshControl()
    var items = [NSDictionary]()
    var passImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "check") != nil {
        } else {
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        let dict = items[(indexPath as NSIndexPath).row]
        
        
        // プロフィール画像
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        // デコードしたデータをUIImage型に変換してImageViewに反映
        let decodeData = (base64encoded:dict["profileImage"])
        let decodedDate = NSData(base64Encoded: decodeData as! String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedDate! as Data)
        profileImageView.image = decodedImage
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        
        // ユーザー名
        let usernameLabel = cell.viewWithTag(2) as! UILabel
        usernameLabel.text = dict["username"] as? String
        
        // 投稿画像
        let postedImageView = cell.viewWithTag(3) as! UIImageView
        // デコードしたデータをUIImage型に変換してImageViewに反映
        let decodeData2 = (base64encoded:dict["postedImage2"])
        let decodedDate2 = NSData(base64Encoded: decodeData2 as! String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodedImage2 = UIImage(data: decodedDate2! as Data)
        postedImageView.image = decodedImage2
        
        // コメント
        let commentTextView = cell.viewWithTag(4) as! UITextView
        commentTextView.text = dict["comment"] as? String
        
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたとき
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            passImage = pickedImage
            performSegue(withIdentifier: "next", sender: nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let editVC = segue.destination as! EditViewController
            editVC.willEditImage = passImage
        }
    }
    
    // MARK: - アプリケーションロジック
    
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
    
    func refresh() {
        
    }
    
    func loadAllData() {
        // https://happystagram-75abf.firebaseio.com/
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let firebase = Database.database().reference(fromURL: "https://happystagram-75abf.firebaseio.com/").child("Posts")
        firebase.queryLimited(toLast: 10).observe(.value) { (snapshot, error) in
            var tempItems = [NSDictionary]()
            for item in(snapshot.children) {
                let child = item as! DataSnapshot
                let dict = child.value
                tempItems.append(dict as! NSDictionary)
            }
            
            self.items = tempItems
            self.items = self.items.reversed()
//            NSLog("アイテム", self.items)
            self.tableView.reloadData()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func showCamera(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func showPhotos(_ sender: Any) {
        openPhoto()
    }
    
    
    
    


}

