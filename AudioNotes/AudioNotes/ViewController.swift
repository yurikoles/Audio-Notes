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
    
    @IBOutlet weak var settingAudioViewController: UIView!
    
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
            setupRecorder()
            soundRecorder.record()
            recordButtonOutlet.setTitle("Stop", for: .normal)
            playButtonOutlet.isEnabled = false
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidEnded), userInfo: nil, repeats: true)
            
        } else {
            soundRecorder.stop()
            recordButtonOutlet.setTitle("Record", for: .normal)
            playButtonOutlet.isEnabled = true
            settingAudioViewController.isHidden = false
            UserDefaults.standard.set(Storage.shared.numberOfRecords, forKey: "audioCount")//сохранение кол-во записей
            timer.invalidate()
            
        }
        
    }
    @IBAction func playAction (_ sender: Any){
        if playButtonOutlet.titleLabel?.text == "Play" {
            playButtonOutlet.setTitle("Stop", for: .normal)
            recordButtonOutlet.isEnabled = false
            setupPlayer()
            soundPlayer.play()
            timer.invalidate()
            time = 0
            timeUISettin()
            
        } else {
            soundPlayer.stop()
            playButtonOutlet.setTitle("Play", for: .normal)
            recordButtonOutlet.isEnabled = false
            
        }
    }
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var timer = Timer()
    var time = 0
    
    
    
    var fileName : String = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            playButtonOutlet.isEnabled = false
            settingAudioViewController.isHidden = true
              if let number : Int = UserDefaults.standard.object(forKey: "audioCount") as? Int{
            Storage.shared.numberOfRecords = number
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        settingUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        settingUI()
    }
    
    // Функция сохраняющая файл в директорию
    func getDocumetnsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func setupRecorder(){
        Storage.shared.numberOfRecords += 1
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(Storage.shared.numberOfRecords).m4a")
        let recordSetting = [AVFormatIDKey : kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey : 320000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()  //метод подготовки записи: создает файл и готовится к записи
        }
        catch{
            print(error)
        }
    }
    
    func setupPlayer() {
        
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(Storage.shared.numberOfRecords).m4a")
        print(audioFileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName) //какой воспроизводим файл
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay() //функция воспроизведения звука
            soundPlayer.volume = 1
        }
        catch {
            print(error)
        }
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

