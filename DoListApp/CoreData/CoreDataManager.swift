//
//  CoreDataManager.swift
//  DoListApp
//
//  Created by YANA on 03/03/2022.
//

import Foundation
import CoreData
import UIKit

struct CoreDataManager {
    
    var models: [UserTasks]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    mutating func fetchData (){
        
        do {
            let request = UserTasks.fetchRequest() as NSFetchRequest <UserTasks>
            let results : [NSManagedObject] = try context.fetch(request) as [UserTasks]
             if (results.count > 0) {
                 //Element exists
                 models = try! context.fetch(request)
                 
             }
             else {
                 //Doesn't exist
                 models = try context.fetch(request)
             }
            
            
        }
           catch let error as NSError{
            print(error.localizedDescription)
      }
    }
    
    
    
    
}
