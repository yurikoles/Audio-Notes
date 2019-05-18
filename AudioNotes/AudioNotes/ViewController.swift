//
//  ViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 17/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    @IBOutlet weak var audioListOutlet: UIButton!
    
    @IBAction func clearAllAudio(_ sender: UIButton) {
        Storage.shared.numberOfRecords = 0
        UserDefaults.standard.set(Storage.shared.numberOfRecords, forKey: "audioCount")
    }
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var timerMinuteLabel: UILabel!
    @IBOutlet weak var timerSecondLabel: UILabel!
    
    @IBOutlet weak var settingAudioView: UIView!
    @IBAction func recordAction (_ sender: Any) {
        if recordButtonOutlet.titleLabel?.text == "Record" {
            workerAudioFile.setupRecorder(viewController: self)
            workerAudioFile.soundRecorder.record()
            recordButtonOutlet.setTitle("Stop", for: .normal)
            playButtonOutlet.isEnabled = false
            
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.timerDidEnded),
                                         userInfo: nil,
                                         repeats: true)
        } else {
            workerAudioFile.soundRecorder.stop()
            if let settingAudioViewController = settingAudioViewController {
                playButtonOutlet.isEnabled = true
                
                //                    Ручное добавление Чайлда
                settingAudioViewController.view.frame = CGRect(origin: CGPoint.zero,
                                                               size: CGSize(width: 343,
                                                                            height: 406))
                settingAudioViewController.view.center = view.center
            }
            
            recordButtonOutlet.setTitle("Record", for: .normal)
            
            showSettings()
            UserDefaults.standard.set(Storage.shared.numberOfRecords, forKey: "audioCount") //сохранение кол-во записей
            timer.invalidate()
        }
    }
    
    @IBAction func playAction (_ sender: Any) {
        if playButtonOutlet.titleLabel?.text == "Play" {
            playButtonOutlet.setTitle("Stop", for: .normal)
            workerAudioFile.setupPlayer(viewController: self)
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
    
    // Ручное добавление Чайлда
    lazy var settingAudioViewController: SettingAudioViewController? = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as? SettingAudioViewController
    }()
    
    var workerAudioFile = WorkerAudioFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let number = UserDefaults.standard.object(forKey: "audioCount") as? Int {
            Storage.shared.numberOfRecords = number
        }
        
        getThemes()
    }
    
    override func viewWillLayoutSubviews() {
        settingUI()
    }
    
    func settingUI() {
        recordButtonOutlet.layer.cornerRadius = recordButtonOutlet.frame.size.height / 2
        playButtonOutlet.layer.cornerRadius = playButtonOutlet.frame.size.height / 2
        audioListOutlet.layer.cornerRadius = audioListOutlet.frame.size.height / 2
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButtonOutlet.isEnabled = true
        playButtonOutlet.setTitle("Play", for: .normal)
    }
    
    @objc private func timerDidEnded() {
        time += 1
        timeUISettin()
    }
    
    func timeUISettin() {
        let second = time % 60
        let minute = (time / 60) % 60
        timerSecondLabel.text = String(second)
        timerMinuteLabel.text = String(minute)
    }
    
    func showSettings() {
        settingAudioView.isHidden = false
    }
    
    func hideSettings() {
        settingAudioView.isHidden = true
    }
    
    func getThemes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fethcRequest : NSFetchRequest<Themes> = Themes.fetchRequest()
        
        do {
            Storage.shared.themes = try context.fetch(fethcRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

