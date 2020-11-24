//
//  ViewController.swift
//  Qrgenrator
//
//  Created by Murteza on 23/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var qrImage:UIImageView!
    @IBOutlet weak var qrField:UITextField!
    
    var activeField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("helooooo")
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction  func QrAction(_ sender: UIButton){
      
        self.qrImage.image = self.generateQRCode(from: self.qrField.text ?? "")
      
    }

    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}
