//
//  UserTasks+CoreDataProperties.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//
//

import Foundation
import CoreData


extension UserTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserTasks> {
        return NSFetchRequest<UserTasks>(entityName: "UserTasks")
    }

    @NSManaged public var taskText: String?
    @NSManaged public var date: String?
    @NSManaged public var category: String?

}

extension UserTasks : Identifiable {

}
