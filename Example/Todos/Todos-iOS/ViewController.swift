//
//  ViewController.swift
//  Todos
//
//  Created by Andrew Shepard on 5/23/16.
//  Copyright © 2016 Andrew Shepard. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let descriptors = [NSSortDescriptor(key: "created", ascending: true)]
        let controller = CoreDataManager.sharedManager.fetchedResultsControllerForEntityName("Todo", sortDescriptors: descriptors)
        
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Todos"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddTodoItem" {
            guard let navController = segue.destinationViewController as? UINavigationController else { return }
            guard let addViewController = navController.viewControllers.first as? AddViewController else { return }
            
            addViewController.context = self.fetchedResultsController.managedObjectContext
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        guard let todo = fetchedResultsController.fetchedObjects?[indexPath.row] as? Todo else { fatalError() }
        
        cell.textLabel?.text = todo.item
        
        return cell
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView?.reloadData()
    }
}