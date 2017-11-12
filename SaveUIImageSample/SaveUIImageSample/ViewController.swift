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
        let resizeImage = resize(image: image)
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let originalPath = documentDirectoryFileURL.appendingPathComponent("saved.png")
            print(originalPath)
            if let png = UIImagePNGRepresentation(image) {
                try! png.write(to: originalPath)
            }
            let resizePath = documentDirectoryFileURL.appendingPathComponent("resize.png")
            print(resizePath)
            if let png = UIImagePNGRepresentation(resizeImage) {
                try! png.write(to: resizePath)
            }
        }
    }

    private func resize(image: UIImage) -> UIImage {
        // 縦横の画素数を半分にする
        let width = image.size.width * 0.5
        let height = image.size.height * 0.5
        // scale の設定が0だとオリジナル画像よりもサイズが大きくなるので1を設定
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizeImage!
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

