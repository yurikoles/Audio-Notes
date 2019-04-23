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
        
        DispatchQueue.main.async {
            
            self.remove()
            //self.view.isUserInteractionEnabled = false
            self.view.isHidden = true
          
        
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("123")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
