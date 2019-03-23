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

    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!

    @IBAction func recordAction (_ sender: Any){
        if recordButtonOutlet.titleLabel?.text == "Record" {
            setupRecorder()
            soundRecorder.record()
            recordButtonOutlet.setTitle("Stop", for: .normal)
            playButtonOutlet.isEnabled = false
        } else {
            soundRecorder.stop()
            recordButtonOutlet.setTitle("Record", for: .normal)
            playButtonOutlet.isEnabled = false
            UserDefaults.standard.set(numberOfRecords, forKey: "audioCount")
        }
        
    }
    @IBAction func playAction (_ sender: Any){
        if playButtonOutlet.titleLabel?.text == "Play" {
            playButtonOutlet.setTitle("Stop", for: .normal)
            recordButtonOutlet.isEnabled = false
            setupPlayer()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
            playButtonOutlet.setTitle("Play", for: .normal)
            recordButtonOutlet.isEnabled = false
        }
    }
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!

    var numberOfRecords : Int = 0
    {
        didSet{
            print(numberOfRecords)
        }
    }
    var fileName : String = "audioFile.m4a"
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            if let number : Int = UserDefaults.standard.object(forKey: "audioCount") as? Int{
                numberOfRecords = number
            }
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        settingUI()
    }
    
    // Функция сохраняющая файл в директорию
    func getDocumetnsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
            return paths[0]

    }
    
    func setupRecorder(){
        numberOfRecords += 1
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(numberOfRecords).m4a")
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
        
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(numberOfRecords).m4a")
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
        playButtonOutlet.isEnabled = false
        recordButtonOutlet.layer.cornerRadius = recordButtonOutlet.frame.size.height/2
        playButtonOutlet.layer.cornerRadius = playButtonOutlet.frame.size.height/2
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButtonOutlet.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButtonOutlet.isEnabled = true
        playButtonOutlet.setTitle("Play", for: .normal)
        
    }
    
    
}

