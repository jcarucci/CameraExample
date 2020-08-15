//
//  ViewController.swift
//  CameraExample
//
//  Created by Jason on 8/15/20.
//  Copyright © 2020 Grand Wazoo. All rights reserved.
//

import AVKit
import UIKit
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(snapPhoto))

    }

    @objc func snapPhoto() {
        print("Hi from snapPhoto")
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
        analyzeImage(image.cgImage!)
    }
    
    func analyzeImage(_ img: CGImage) {
        guard let model1 = try? VNCoreMLModel(for: SqueezeNet().model) else { return }
        //guard let model2 = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model1) { [unowned self] (finishedReq, err) in
            DispatchQueue.main.async {
                guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
                
                guard let f = results.first else { return }
                print("\(f.identifier) - Confidence: \(f.confidence)")
            }
        }
        try? VNImageRequestHandler(cgImage: img, options: [:]).perform([request])
    }
}
