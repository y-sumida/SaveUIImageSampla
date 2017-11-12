//
//  ViewController.swift
//  SaveUIImageSample
//
//  Created by Yuki Sumida on 2017/11/11.
//  Copyright © 2017年 Yuki Sumida. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
    }

    private func saveImage(image: UIImage) {
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let pngPath = documentDirectoryFileURL.appendingPathComponent("saved.png")
            print(pngPath)
            if let png = UIImagePNGRepresentation(image) {
                try! png.write(to: pngPath)
            }
            let jpgPath = documentDirectoryFileURL.appendingPathComponent("saved.jpg")
            print(jpgPath)
            if let png = UIImageJPEGRepresentation(image, 0.75) {
                try! png.write(to: jpgPath)
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        self.saveImage(image: image)
        self.dismiss(animated: true, completion: nil)
    }
}

