//
//  Task.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import Foundation
import CoreData

// description task
public class Task: NSManagedObject, Identifiable {
    @NSManaged public var name: String
    @NSManaged public var text: String
    @NSManaged public var createdDate: Date
}

extension Task {
    // task request
    static func getAllTask() -> NSFetchRequest<Task> {
        if  let request: NSFetchRequest<Task> = Task.fetchRequest() as? NSFetchRequest<Task> {
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sortDescriptor]

            return request
        } else {
            print(Error.self)
        }
    }
}

class TaskModel {

    // singleton
    static let defaults = TaskModel()

    private init() {}

    let viewContext = PersistenceController.shared.container.viewContext

    // treatment context
    private func saveContext() {
        do {
            try self.viewContext.save()
        } catch {
            print("save context error")
        }
    }

    // treatment task data
    func removeTask(at offsets: IndexSet) {
        var tasks: [Task]
        do {
        tasks = try viewContext.fetch(Task.getAllTask())

        for index in offsets {
            let removeObject = tasks[index]

            viewContext.delete(removeObject)

            saveContext()
        }} catch {
            print("remove task error")
        }
    }

    func createNewTask(name: String, text: String = "") {
        let task = Task(context: self.viewContext)

        task.name = name
        task.text = text
        task.createdDate = Date()

        saveContext()
    }
}
