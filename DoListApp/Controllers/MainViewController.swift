//
//  ViewController.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var coreData = CoreDataManager()
    let rowHeight = CGFloat(145)
   
    
    
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
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        addButton.frame = CGRect(x: view.frame.size.width - 72,
                                 y: view.frame.size.height - 100,
                                 width: 60,
                                 height: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        setupView()
        fetchData()
    }
    
    func setupView(){
        
        view.addSubview(table)
        view.addSubview(addButton)
        table.delegate = self
        table.dataSource = self
        table.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeaderView")
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        view.backgroundColor = .systemBackground
        table.backgroundColor = .systemBackground
    }
    
    
    @objc func didTapAddButton(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let createTaskVc  = storyBoard.instantiateViewController(withIdentifier: "CreateTaskViewController") as! CreateTaskViewController
        createTaskVc.modalPresentationStyle = .fullScreen
        createTaskVc.view.autoresizingMask = .flexibleHeight
        createTaskVc.callback = {
            self.fetchData()
            self.table.reloadData()
        }
        present(createTaskVc,animated: true)
        
            }
    
    // CoreData fetch
    
    func fetchData (){
        coreData.fetchData()
        
        DispatchQueue.main.async {
            self.table.reloadData()
    }
        
 }
    

    
}

// MARK: TableView


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = coreData.models?.count ?? 0
        if numberOfRows == 0 {
            
            let emptyLabel = UILabel(frame: CGRect(x:0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height/4))
                emptyLabel.text = "You have no tasks"
                emptyLabel.textAlignment = .center
                tableView.backgroundView = emptyLabel
                tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
                return 0
            } else {
                
                tableView.backgroundView = .none
                return numberOfRows
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .systemBackground
        guard let models = coreData.models else {
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
            
                let task = self?.coreData.models![indexPath.row]
            // remove action
                self?.coreData.context.delete((task ?? self?.coreData.models?[0])!) ?? nil
            
            // save data
            do{
                try self?.coreData.context.save()
            }
            catch let error as NSError{
                
                 print(error.localizedDescription)
                
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
    
    //set table view animation
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
                   UIView.animate(
                    withDuration: 0.8,
                       delay: 0.05 * Double(indexPath.row),
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseInOut],
                       animations: {
                           cell.transform = CGAffineTransform(translationX: 0, y: 0)
                   })
    }
    
}
