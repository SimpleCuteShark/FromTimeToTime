//
//  ContentView.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import SwiftUI
import CoreData

// view with list of task
struct TaskListView: View {

    @FetchRequest(fetchRequest: Task.getAllTask()) var tasks: FetchedResults<Task>

    @State private var newTask = ""

    var body: some View {
        NavigationView {
            List {
                // section make new task
                Section(header: Text("Добавить задачу"), content: {
                    GeometryReader {_ in
                        HStack {
                            TextField("Название задачи", text: $newTask)
                            Spacer()
                            if newTask.isEmpty {
                                // transition on view editor
                                NavigationLink(destination: EditorTaskView()) {
                                    Text("Создать задачу")
                                } } else {
                                    // create fast task
                                    Button(action: {
                                        TaskModel.defaults.createNewTask(name: self.newTask)
                                        self.newTask = ""
                                    }, label: {
                                        Image(systemName: "plus.circle.fill")
                                    })
                                }
                        }
                    }
                })
                // section with all task
                Section(header: Text("Ваши задачи"), content: {
                    ForEach(self.tasks, id: \.self) { task in
                        HStack {
                            // cell
                            VStack(alignment: .leading) {
                                Text(task.name).font(.headline)
                                if !task.text.isEmpty {
                                    Text(task.text)
                                }
                                Text("\(task.createdDate)").font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: TaskModel.defaults.removeTask)
                })
            }
            .navigationBarTitle(Text("Доска задач"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
