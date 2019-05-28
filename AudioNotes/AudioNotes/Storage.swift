//
//  storage.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 23/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData

class Storage {
    static func saveAudio(_ url : URL) -> Audio? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Audio", in: context)
        let audioEntity = NSManagedObject(entity: entity!, insertInto: context) as! Audio
        audioEntity.fileURL = url
        return audioEntity
//        audioEntity.theme = themes[0]

//        do {
//            try context.save()
//            print("Save! Good Job!")
//            return audioEntity
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
    }

    static func saveTheme(_ name : String) -> Theme? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Theme", in: context)
        let themeEntity = NSManagedObject(entity: entity!, insertInto: context) as! Theme
        themeEntity.name = name

        do {
            try context.save()
            print("Save! Good Job!")
            return themeEntity
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    static var themes: [Theme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest : NSFetchRequest<Theme> = Theme.fetchRequest()

        do {
            let themes = try context.fetch(fetchRequest)
            return themes
        } catch {
            print(error.localizedDescription)
            return [Theme]()
        }
    }

    static var audios: [Audio] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest : NSFetchRequest<Audio> = Audio.fetchRequest()

        do {
            let audios = try context.fetch(fetchRequest)
            return audios
        } catch {
            print(error.localizedDescription)
            return [Audio]()
        }
    }

    static func audios(for theme: Theme) -> [Audio] {
        return theme.audios?.allObjects as! [Audio]
    }
}
