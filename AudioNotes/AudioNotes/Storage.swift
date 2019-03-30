//
//  storage.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 23/03/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation
class Storage  {
    
    static var shared = Storage()

    var numberOfRecords : Int = 0
    {
        didSet{
            print(numberOfRecords)
        }
    }
    
}
