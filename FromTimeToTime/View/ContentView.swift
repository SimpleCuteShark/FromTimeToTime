//
//  ContentView.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @FetchRequest(fetchRequest: Task.getAllTask()) var tasks: FetchedResults<Task>
    
    @State private var newTask = ""
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Добавить задачу"), content: {
                    GeometryReader() {_ in
                        HStack {
                            TextField("Название задачи", text: $newTask)
                            Spacer()
                            if newTask == "" {
                                NavigationLink(destination: NewTaskView()) {
                                    Text("Создать задачу")
                                } } else {
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
                Section(header: Text("Ваши задачи"), content: {
                    ForEach(self.tasks, id: \.self) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.name).font(.headline)
                                Text("\(task.createdDate)").font(.caption)
                            }
                        }
                    }
                })
            }.navigationBarTitle(Text("Доска задач"))
            // .navigationBarItems(trailing: EditButton())
        }
    }
}

struct NewTaskView: View {
    @State private var govno = ""
    @State private var mocha = ""
    
    var body: some View {
        Text("test")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
