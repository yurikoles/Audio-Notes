//
//  ViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 17/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var settingAudioView: UIView!
    
    @IBAction func clearAllAudio(_ sender: UIButton) {
        Storage.shared.numberOfRecords = 0
        UserDefaults.standard.set(Storage.shared.numberOfRecords, forKey: "audioCount")
    }
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var timerMinuteLabel: UILabel!
    @IBOutlet weak var timerSecondLabel: UILabel!
    
    @IBAction func recordAction (_ sender: Any){
        
        if recordButtonOutlet.titleLabel?.text == "Record" {
            
                self.workerAudioFile.setupRecorder(viewController: self)
                self.workerAudioFile.soundRecorder.record()
             DispatchQueue.main.async {
                self.recordButtonOutlet.setTitle("Stop", for: .normal)
                self.playButtonOutlet.isEnabled = false
            }
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerDidEnded), userInfo: nil, repeats: true)
        } else {
            
            // DispatchQueue.main.async {
                self.workerAudioFile.soundRecorder.stop()
                self.add(self.settingAudioViewController)
                self.recordButtonOutlet.setTitle("Record", for: .normal)
                self.playButtonOutlet.isEnabled = true
                self.settingAudioView.isHidden = false
            UserDefaults.standard.set(Storage.shared.numberOfRecords, forKey: "audioCount")//сохранение кол-во записей
                self.timer.invalidate()
           // }
        }
    }
    @IBAction func playAction (_ sender: Any){
        if playButtonOutlet.titleLabel?.text == "Play" {
            playButtonOutlet.setTitle("Stop", for: .normal)
            recordButtonOutlet.isEnabled = false
            self.workerAudioFile.setupPlayer(viewController: self)
            workerAudioFile.soundPlayer.play()
            timer.invalidate()
            time = 0
            timeUISettin()
            
        } else {
            workerAudioFile.soundPlayer.stop()
            playButtonOutlet.setTitle("Play", for: .normal)
            recordButtonOutlet.isEnabled = false
            
        }
    }
    

    var timer = Timer()
    var time = 0
    var settingAudioViewController = SettingAudioViewController()
    var workerAudioFile = WorkerAudioFile()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            playButtonOutlet.isEnabled = false
            settingAudioView.isHidden = true
        
              if let number : Int = UserDefaults.standard.object(forKey: "audioCount") as? Int{
            Storage.shared.numberOfRecords = number
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillLayoutSubviews() {
        settingUI()
    }
    
    
    
    
    func settingUI() {
       // playButtonOutlet.isEnabled = false
        recordButtonOutlet.layer.cornerRadius = recordButtonOutlet.frame.size.height/2
        playButtonOutlet.layer.cornerRadius = playButtonOutlet.frame.size.height/2
       
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //playButtonOutlet.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButtonOutlet.isEnabled = true
        playButtonOutlet.setTitle("Play", for: .normal)
        
    }
    
    @objc private func timerDidEnded() {
        
        time += 1
        timeUISettin()
    }
    
    func timeUISettin(){
        
        let second = time%60
        let minute = (time/60)%60
        timerSecondLabel.text = String(second)
        timerMinuteLabel.text = String(minute)
    }
}


 
