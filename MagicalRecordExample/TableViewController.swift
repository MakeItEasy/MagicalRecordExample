//
//  ViewController.swift
//  MagicalRecordExample
//
//  Created by moyan on 15-2-4.
//  Copyright (c) 2015年 moyan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var frc : NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化查询所有数据
        initFrc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =====================================================================================
    // TableView DataSource & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.frc.fetchedObjects != nil {
            return self.frc.fetchedObjects!.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath) as UserInfoTableViewCell
        var user = self.frc.fetchedObjects![indexPath.row] as User
        cell.configuration(user)
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete 删除数据
            frc.fetchedObjects![indexPath.row].MR_deleteEntity()
        } else if editingStyle == .Insert {
        }
    }

    // =================================================================================
    // NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
        // 特别注意：只有执行了这里的代码，Create,Delete以及Update操作才能反应到数据库中
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type) {
            
        case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath!), withRowAnimation: UITableViewRowAnimation.Fade)
            break;
        case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!), withRowAnimation: UITableViewRowAnimation.Fade)
            break;
        case NSFetchedResultsChangeType.Update:
            tableView.reloadRowsAtIndexPaths(NSArray(object: indexPath!), withRowAnimation: UITableViewRowAnimation.None)
            break;
        default:
            break;
        }
    }

    // =====================================================================================
    // 初始化查询所有数据
    func initFrc() {
        // 查询所有数据
        let userFetchRequest = User.MR_requestAllSortedBy("name", ascending: true)
        frc = NSFetchedResultsController(fetchRequest: userFetchRequest, managedObjectContext: NSManagedObjectContext.MR_defaultContext(), sectionNameKeyPath: nil, cacheName: nil)
        frc.performFetch(nil)
        frc.delegate = self
    }

    // =====================================================================================
    // Unwind To This Controller
    @IBAction func backToTableViewUnwind(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editUserInfoSegue" {
            // dc.user = User.MR_findFirst() as User
            var dc = segue.destinationViewController as UserDetailViewController
            var cell = sender as UserInfoTableViewCell
            dc.user = cell.user
        }
    }
    
    // 左上角Edit处理
    @IBAction func btnEditTapped(sender: AnyObject) {
        self.tableView.editing = !self.tableView.editing
    }

}

