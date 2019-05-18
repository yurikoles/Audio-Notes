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

        if let parent = parent as? ViewController {
            parent.hideSettings()
        }
    }
    
    @IBOutlet weak var selectThemesPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectThemesPickerView.dataSource = self
        selectThemesPickerView.delegate = self

    }
}

extension SettingAudioViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return  Storage.shared.themes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //        let s = Storage.shared.themes[row].currentThemes
        return Storage.shared.themes[row].currentThemes
    }
    
}
