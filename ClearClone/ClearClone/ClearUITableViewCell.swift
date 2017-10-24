//
//  ClearUITableViewCell.swift
//  ClearClone
//
//  Created by Michael Pettiford on 10/24/17.
//  Copyright © 2017 Michael Pettiford. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    // indicates that the given item has been deleted
    func toDoItemDeleted(todoItem: ToDoItem)
}

class ClearUITableViewCell : UITableViewCell {
    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    var completeOnDragRelease = false
    // The object that acts as delegate for this cell.
    var delegate: TableViewCellDelegate?
    // The item that this cell renders.
    var toDoItem: ToDoItem?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // gradient layer for cell
        gradientLayer.frame = bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(ClearUITableViewCell.handlePan))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: self)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
        }
        // 3
        /*
        if recognizer.state == .ended {
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                                       width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                // if the item is not being deleted, snap back to the original location
                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
                
            } else {
                if delegate != nil && toDoItem != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.toDoItemDeleted(todoItem: toDoItem!)
                }
            }
        }
        */
        if recognizer.state == .ended {
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                                       width: bounds.size.width, height: bounds.size.height)
            if deleteOnDragRelease {
                if delegate != nil && toDoItem != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.toDoItemDeleted(todoItem: toDoItem!)
                }
            } else if completeOnDragRelease {
                if toDoItem != nil {
                    toDoItem!.completed = true
                }
                var tester = self.textLabel?.attributedText
                //[NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSStrikethroughColorAttributeName: UIColor.red]
                tester?.attribute(NSStrike, range: NSMakeRange(0, index.length))
                label.strikeThrough = true
                itemCompleteLayer.hidden = false
                
                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
            } else {
                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
            }
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
}
