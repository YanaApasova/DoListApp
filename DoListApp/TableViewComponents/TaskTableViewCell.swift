//
//  TaskTableViewCell.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//

import UIKit
import CoreData

class TaskTableViewCell: UITableViewCell {
    
    
    var items: [UserTasks]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
     func fetchData(){
        
        do {
            let request = UserTasks.fetchRequest() as NSFetchRequest <UserTasks>
            self.items =  try context.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
        
        }
    
    static var identifier = "TaskTableViewCell"
    
    @IBOutlet var tasktDateLabel: UILabel!
    @IBOutlet var taskTextLabel: UILabel!
    
    @IBOutlet var taskImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    static func nib() -> UINib{
        return UINib( nibName: "TaskTableViewCell", bundle: nil)
    }
    
    func configure (with model: UserTasks){
        self.taskTextLabel.text = model.taskText?.uppercased()
      
        self.tasktDateLabel.text = model.date
        self.taskImage.contentMode = .scaleAspectFit
        
        if model.category == "Work" {
            self.taskImage.image = UIImage(named: "Work")!
        }
        else if model.category == "Travelling" {
            self.taskImage.image = UIImage(named: "Travelling")
        }
        else if model.category == "Home" {
            self.taskImage.image = UIImage(named: "Home")
        }
        
        else if model.category == "Food" {
            self.taskImage.image = UIImage(named: "Food")
        }
        
        else if model.category == "Shopping" {
            self.taskImage.image = UIImage(named: "Shopping")
        }
        else if model.category == "Study" {
            self.taskImage.image = UIImage(named: "Study")
        }
    }
}
