//
//  ViewController.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var models: [UserTasks]?
    
    // persistent container CoreData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    private let addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        
        button.backgroundColor = .systemPink
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.setImage(image, for: .normal)
        return button
    }()

    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(TaskTableViewCell.nib(), forCellReuseIdentifier:TaskTableViewCell.identifier)
       
        return table
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        view.addSubview(addButton)
        table.delegate = self
        table.dataSource = self
        table.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeaderView")
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        view.backgroundColor = .systemBackground
        table.backgroundColor = .systemBackground
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        addButton.frame = CGRect(x: view.frame.size.width - 72,
                                 y: view.frame.size.height - 100,
                                 width: 60,
                                 height: 60)
    }
    
    
    
    @objc func didTapAddButton(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let createTaskVc  = storyBoard.instantiateViewController(withIdentifier: "CreateTaskViewController") as! CreateTaskViewController
        createTaskVc.modalPresentationStyle = .fullScreen
        createTaskVc.callback = {
            self.fetchData()
            self.table.reloadData()
        }
        present(createTaskVc,animated: true)
        
            }
    
    // CoreData fetch
    
    func fetchData (){
        
        do {
            let request = UserTasks.fetchRequest() as NSFetchRequest <UserTasks>
            let results : [NSManagedObject] = try context.fetch(request) as [UserTasks]
             if (results.count > 0) {
                 //Element exists
                 self.models = try! context.fetch(request)
                 
             }
             else {
                 //Doesn't exist
                 self.models = try context.fetch(request)
             }
            
            
        }
           catch let error as NSError{
            print(error.localizedDescription)
      }
        DispatchQueue.main.async {
            self.table.reloadData()
    }
        
 }
}

// MARK: TableView


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = models?.count ?? 0
        if numberOfRows == 0 {
            
            let emptyLabel = UILabel(frame: CGRect(x:0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height/4))
                emptyLabel.text = "You have no tasks"
                emptyLabel.textAlignment = .center
                tableView.backgroundView = emptyLabel
                tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
                return 0
            } else {
               
                return numberOfRows
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .systemBackground
        guard let models = models else {
            return cell
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        let action = UIContextualAction(style: .destructive, title: "") {
            [weak self] (action, view, completionHandler) in
            
            let ac = UIAlertController(title: "", message: "Do you want to delete?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default){ [weak self] _ in
            
            let task = self?.models![indexPath.row]
            // remove action
            self?.context.delete((task ?? self?.models?[0])!) ?? nil
            
            // save data
            do{
               try self?.context.save()
            }
            catch{
                
            }
            //data refetch
                self?.fetchData()
            })
                
            ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self?.present(ac, animated: true)
            completionHandler(true)
        }
        action.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    
    //  MARK: HEADER
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView")
        
        sectionHeader?.backgroundView = UIView(frame: sectionHeader.self!.bounds)
        sectionHeader?.backgroundView!.backgroundColor = UIColor(patternImage: UIImage(named: "HeaderView")!)
        sectionHeader?.backgroundView?.layer.cornerRadius = 10
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return sectionHeader
      
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
   
    
}
