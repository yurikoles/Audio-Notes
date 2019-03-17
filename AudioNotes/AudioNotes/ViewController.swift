//
//  ViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 17/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stopButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordButtonOutlet.layer.cornerRadius = recordButtonOutlet.frame.size.height/2
        stopButtonOutlet.layer.cornerRadius = stopButtonOutlet.frame.size.height/2
    }


}

