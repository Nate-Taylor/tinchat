//
//  ViewController.swift
//  tinchat
//
//  Created by nate.taylor_mac on 27.09.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    @IBOutlet weak var placeholder: UIImageView!
    @IBOutlet weak var choiceIcon: UIImageView!
    @IBOutlet weak var choiceIconBackground: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var viewForEditButton: UIView!
    @IBOutlet weak var viewForTextFields: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAboutMe: UITextField!
    var activeTextField: UITextField!
    
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     //   nameLabel.text="Iron man"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
 
        fatalError("init(coder:) has not been implemented")
    }*/
    
    func printButtonFrame(_ arg: String) {
        print("Frame of edit button in \(arg):\n\(editButton.frame)")
    }
    
    /*required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //вызов printButtonFrame(..) будет ошибкой, т.к. Outlet-ы еще не подключены
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.delegate = self
        textFieldAboutMe.delegate = self
        
        choiceIconBackground.layer.borderWidth = 1
        choiceIconBackground.layer.borderColor = UIColor.white.cgColor
        choiceIconBackground.layer.cornerRadius = choiceIconBackground.frame.size.width / 2
        choiceIconBackground.clipsToBounds = true
        placeholder.layer.cornerRadius = choiceIconBackground.layer.cornerRadius
        placeholder.clipsToBounds = true
        
        editButton.layer.cornerRadius = 13
        editButton.layer.borderWidth = 1
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        printButtonFrame(#function)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat! = profileStackView.frame.origin.y+self.viewForTextFields.frame.origin.y+self.activeTextField.frame.origin.y

        if view.frame.origin.y >= 0 {
            if editingTextFieldY > keyboardY-50 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY-50)),width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
          self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(profileStackView.frame.origin.y)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printButtonFrame(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printButtonFrame(#function)
        /*
     Здесь размер меняется, потому как view появилась и изменилась соответствующим образом, чтобы
     поместиться на экране. Так как в раскадровке view была "заточена" на iphone 5SE, а появилась
     на экране iphone 8 plus, frame увеличился.
     */
    }

    @IBAction func editAction(_ sender: Any) {
        /*
        guard let button=sender as? UIButton else {
            ///
            return
        }
         
         button!.titleLabel.text="11"
        */
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        print("select profile image")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "photo source", message: nil, preferredStyle: .actionSheet)
        
        // camera permission
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authorizationStatus {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    if granted {
                        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
                            imagePickerController.sourceType = .camera
                            self.present(imagePickerController, animated: true, completion: nil)
                        }
                        else {
                            print("camera is unavailable")
                        }
                    }
                    else {
                        print("access denied")
                    }
                }
            case .authorized:
                if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }
                else {
                    print("camera is unavailable")
                }
            case .denied, .restricted:
                print("denied")
            }
        }))
        
        // Photo Library permission and access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        placeholder.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
