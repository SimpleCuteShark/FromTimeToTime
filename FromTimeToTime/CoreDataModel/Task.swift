//
//  Task.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import Foundation
import CoreData

public class Task: NSManagedObject, Identifiable {
    @NSManaged public var name: String
    @NSManaged public var text: String
    @NSManaged public var createdDate: Date
}

extension Task {
    static func getAllTask() -> NSFetchRequest<Task> {
        let request: NSFetchRequest<Task> = Task.fetchRequest() as! NSFetchRequest<Task>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
