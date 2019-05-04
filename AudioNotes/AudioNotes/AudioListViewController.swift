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
    
    
    @IBOutlet weak var addThemsOutlet: UIButton!
    @IBOutlet weak var audioCollection: UICollectionView!
    
    
    
    @IBAction func addThemesButton(_ sender: Any) {callingAlert()}
    
    let vc = ViewController()
    let workerAudioFile = WorkerAudioFile();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addThemsOutlet.layer.cornerRadius = addThemsOutlet.frame.size.height/2
        self.audioCollection.reloadData()
        audioCollection.delegate = self
        audioCollection.dataSource = self
//        audioCollection.
        }
    
    
 
}


extension AudioListViewController : UICollectionViewDelegate,UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            let count = Storage.shared.numberOfRecords
            return count
        }else{
            return 5}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.audioCellLabel.text = String(indexPath.row+1)
        cell.backgroundColor = UIColor.green
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tab \(indexPath.row+1)")
        
        let path = workerAudioFile.getDocumetnsDirector().appendingPathComponent("Records\(indexPath.row+1).m4a")
        
        do
        {
            workerAudioFile.soundPlayer = try AVAudioPlayer(contentsOf: path)
            workerAudioFile.soundPlayer.play()
        }catch{
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 2
        
    }
    
  //  - MARK : Header section in collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
            as? CollectionReusableView{
            sectionHeader.sectionHeaderlabel.text = "Section \(indexPath.section)"
            return sectionHeader
        }
        return UICollectionReusableView()

    }

    private func callingAlert(){
        let alertController = UIAlertController(title: "Новая тема", message: "Напишите название новой темы", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            print("save")
            
            if alertController.textFields != nil && alertController.textFields![0].text != nil {
                Storage.shared.themes.append(String(alertController.textFields![0].text!))     }
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (UIAlertAction) in
            print("cancel")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true , completion: nil)
    }
    
}
