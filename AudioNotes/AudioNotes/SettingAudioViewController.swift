//
//  SettingAudioViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 30/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class SettingAudioViewController: UIViewController {
    
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var CloseViewOutlet: UIButton!
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        workerAudioFile.soundRecorder?.deleteRecording()
        closeChildView()
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        closeChildView()
    }
    
    @IBAction func CloseView(_ sender: UIButton) {
        
       closeChildView()
    }
    
    @IBOutlet weak var selectThemesPickerView: UIPickerView!
    
    
    var workerAudioFile = WorkerAudioFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectThemesPickerView.dataSource = self
        selectThemesPickerView.delegate = self
        
    }
    
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        saveButtonOutlet.layer.cornerRadius = saveButtonOutlet.frame.size.height / 2
        deleteButtonOutlet.layer.cornerRadius = deleteButtonOutlet.frame.size.height / 2
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
    
    private func closeChildView(){
        if let parent = parent as? ViewController {parent.hideSettings()}
    }
}
