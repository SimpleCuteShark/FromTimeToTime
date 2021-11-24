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


class TaskModel {
    
    static let defaults = TaskModel()
    
    private init() {}
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    
    public func createNewTask(name: String, text: String = "") {
        let task = Task(context: self.viewContext)
        
        task.name = name
        task.text = text
        task.createdDate = Date()
        
        do{
            try self.viewContext.save()
        } catch {
            print(error)
        }
    }
}
