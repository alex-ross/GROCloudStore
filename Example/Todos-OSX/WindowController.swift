//
//  WindowController.swift
//  Todos
//
//  Created by Andrew Shepard on 5/26/16.
//  Copyright © 2016 Andrew Shepard. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    lazy var arrayController: NSArrayController = {
        let descriptors = [SortDescriptor(key: "created", ascending: true)]
        let controller = CoreDataManager.sharedManager.arrayControllerForEntityName("Todo", sortDescriptors: descriptors)
        
        let context = CoreDataManager.sharedManager.managedObjectContext
        controller.managedObjectContext = context
        
        return controller
    }()

    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let viewController = self.contentViewController as? ViewController {
            viewController.representedObject = self.arrayController
        }
    }

    @IBAction func handleAddButton(_ sender: AnyObject) {
        // TODO
    }
}
