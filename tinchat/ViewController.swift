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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var placeholder: UIImageView!
    @IBOutlet weak var choiceIcon: UIImageView!
    @IBOutlet weak var choiceIconBackground: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     //   nameLabel.text="Iron man"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choiceIconBackground.layer.cornerRadius = choiceIconBackground.frame.size.width / 2
        choiceIconBackground.clipsToBounds = true
        placeholder.layer.cornerRadius = choiceIconBackground.layer.cornerRadius
        placeholder.clipsToBounds = true
        
        editButton.layer.cornerRadius = 15
        editButton.layer.borderWidth = 2
        
       /* choiceIcon.layer.cornerRadius = choiceIcon.frame.size.width / 2
        choiceIcon.clipsToBounds = true
        placeholder.layer.cornerRadius = choiceIcon.layer.cornerRadius
        placeholder.clipsToBounds = true */

        // Do any additional setup after loading the view.
        print("Frame of edit button in \(#function):\n\(editButton.frame)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Frame of edit button in \(#function):\n\(editButton.frame)")
    }

    @IBAction func editAction(_ sender: Any) {
        /*
        guard let button=sender as? UIButton else {
            ///
            return
        }
 
 
        let button= (sender as? UIButton) ?? UIButton() //если кнопки нет, создай новую
         
         или через if let button...
         */
        
 //       button
 //       button!.titleLabel.text="11"
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: nil, preferredStyle: .actionSheet)
        
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
