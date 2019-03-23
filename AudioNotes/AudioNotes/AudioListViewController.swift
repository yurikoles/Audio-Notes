//
//  AudioListViewController.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 23/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import AVFoundation

class AudioListViewController: UIViewController {
    
    
    @IBOutlet weak var audioCollection: UICollectionView!
    
    let vc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioCollection.reloadData()
        audioCollection.delegate = self
        audioCollection.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
}


extension AudioListViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = Storage.shared.numberOfRecords + 1
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.audioCellLabel.text = String(indexPath.row+1)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tab \(indexPath.row+1)")
        
        let path = vc.getDocumetnsDirector().appendingPathComponent("Records\(indexPath.row+1).m4a")
        
        do
        {
            vc.soundPlayer = try AVAudioPlayer(contentsOf: path)
            vc.soundPlayer.play()
        }catch{
            
        }
    }
    
}
