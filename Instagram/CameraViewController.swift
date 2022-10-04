//
//  CameraViewController.swift
//  Instagram
//
//  Created by Land Strip on 10/3/22.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let post = PFObject(className: "Posts")
                
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
                
                
        //get data from url and add ! to unwrap it
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
                
        post["image"] = file
                
        post.saveInBackground { (sucess, error) in
            if sucess {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
                
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
            
        let size = CGSize(width: 300, height: 300)
        let scaledImage =  image.af_imageScaled(to: size)
            
        imageView.image =  scaledImage
            
        dismiss(animated: true, completion: nil)
        }
    }
