//
//  ContentView.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Task.getAllTask()) var tasks: FetchedResults<Task>
    
    @State private var newTask = ""
    

    var body: some View {
        List {
            Section(header: Text("Добавить задачу"), content: {
                HStack {
                    TextField("Название задачи", text: $newTask)
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
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
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
