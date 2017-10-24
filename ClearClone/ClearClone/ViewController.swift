//
//  ViewController.swift
//  ClearClone
//
//  Created by Michael Pettiford on 10/24/17.
//  Copyright © 2017 Michael Pettiford. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var toDoItems : Array = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ClearUITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 50.0
        tableView.backgroundColor = UIColor.black
        
        if toDoItems.count > 0 {
            return
        }
        
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "feed the cat")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "buy eggs")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "watch WWDC videos")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "rule the Web")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "buy a new iPhone")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "darn holes in socks")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "write this tutorial")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "master Swift")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "learn to draw")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "get more exercise")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "catch up with Mom")))
        toDoItems.append(ToDoItem(text: NSMutableAttributedString(string: "get a hair cut")))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ClearUITableViewCell
        cell.textLabel?.backgroundColor = UIColor.clear
        let item = toDoItems[indexPath.row]
        //cell.textLabel?.text = item.text
        cell.textLabel?.attributedText = item.text
        cell.selectionStyle = .none
        cell.delegate = self
        cell.toDoItem = item
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    
    func toDoItemDeleted(todoItem: ToDoItem) {
        let index = (toDoItems as NSArray).index(of: todoItem)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        toDoItems.remove(at: index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPathForRow as IndexPath], with: .fade)
        tableView.endUpdates()
    }
    
    
}

