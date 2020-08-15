//
//  ViewController.swift
//  CameraExample
//
//  Created by Jason on 8/15/20.
//  Copyright © 2020 Grand Wazoo. All rights reserved.
//

import UIKit

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
}
