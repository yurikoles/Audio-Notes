//
//  Extension.swift
//  AudioNotes
//
//  Created by Алексей ]Чанов on 07/04/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
