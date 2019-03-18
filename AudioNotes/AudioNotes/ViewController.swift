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
            soundRecorder.record()
            recordButtonOutlet.setTitle("Stop", for: .normal)
            playButtonOutlet.isEnabled = false
        } else {
            soundRecorder.stop()
            recordButtonOutlet.setTitle("Record", for: .normal)
            playButtonOutlet.isEnabled = false
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
    
    var fileName : String = "audioFile.m4a"
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            playButtonOutlet.isEnabled = false
            setupRecorder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        settingUI()
    }
    
    
    func getDocumetnsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func setupRecorder(){
        let audioFileName = getDocumetnsDirector().appendingPathComponent(fileName)
        let recordSetting = [AVFormatIDKey : kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey : 320000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
        catch{
            print(error)
        }
    }
    
    func setupPlayer() {
        
        let audioFileName = getDocumetnsDirector().appendingPathComponent(fileName)
        print(audioFileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    func settingUI() {
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

