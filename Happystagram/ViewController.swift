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
        
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        
        let usernameLabel = cell.viewWithTag(2) as! UILabel
        
        let postedImageView = cell.viewWithTag(3) as! UIImageView
        
        let commentTextView = cell.viewWithTag(4) as! UITextView
        
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //backImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
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

