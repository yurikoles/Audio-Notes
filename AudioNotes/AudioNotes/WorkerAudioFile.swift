//
//  WorkerAudioFile.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 23/04/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import AVFoundation

class WorkerAudioFile {
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var timer = Timer()
    var time = 0
    var settingAudioViewController = SettingAudioViewController()
    var fileName : String = "audioFile.m4a"
    

    // Функция сохраняющая файл в директорию
    func getDocumetnsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func setupRecorder(viewController: UIViewController ){
        Storage.shared.numberOfRecords += 1
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(Storage.shared.numberOfRecords).m4a")
        let recordSetting = [AVFormatIDKey : kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey : 320000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = viewController as? AVAudioRecorderDelegate
            soundRecorder.prepareToRecord()  //метод подготовки записи: создает файл и готовится к записи
        }
        catch{
            print(error)
        }
    }
    
    func setupPlayer(viewController: UIViewController) {
        
        let audioFileName = getDocumetnsDirector().appendingPathComponent("Records\(Storage.shared.numberOfRecords).m4a")
        print(audioFileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName) //какой воспроизводим файл
            soundPlayer.delegate = viewController as? AVAudioPlayerDelegate 
            soundPlayer.prepareToPlay() //функция воспроизведения звука
            soundPlayer.volume = 1
        }
        catch {
            print(error)
        }
    }
}
