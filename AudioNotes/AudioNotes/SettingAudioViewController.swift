//
//  SettingAudioViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 30/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class SettingAudioViewController: UIViewController {
    @IBOutlet weak var CloseViewOutlet: UIButton!

    @IBAction func CloseView(_ sender: UIButton) {
//        remove()
//        vc.hideSettings()
        if let parent = parent as? ViewController {
            parent.hideSettings()
        }
    }

//   var vc = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("123")
    }
}
