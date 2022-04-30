//
//  EditorTaskView.swift
//  FromTimeToTime
//
//  Created by Александр Романцов on 17.12.2021.
//

import SwiftUI

struct EditorTaskView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var name = ""
    @State private var description = ""

    var tags = ["clear", "red", "green", "blue"]
    var tagsColor = [Color.purple, Color.red, Color.green, Color.gray]
    
    @State private var selectedTag = "clear"

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 600)
                VStack {
                    Text("Создать задачу")
                    VStack {

                        HStack(spacing: 15) {

                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color.black)

                            TextField("Название задачи", text: self.$name)
                                .accentColor(Color.black)
                        }

                        Divider().background(Color.black.opacity(0.5))
                    }
                    .padding(.horizontal, 50)
                    .padding(.top, 40)

                    VStack {

                        HStack(spacing: 15) {

                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color.black)

                            TextEditor(text: self.$description)
                                .accentColor(Color.black)
                                .foregroundColor(Color.black)
                                .background(Color.blue)
                                .frame(width: 255, height: 150)
                        }

                        Divider().background(Color.black.opacity(0.5))
                    }
                    .padding(.horizontal, 50)
                    .padding(.top, 40)
                    HStack {
                    GeometryReader {_ in
                    Picker("Теги", selection: $selectedTag, content: {
                        ForEach(tags, id: \.self) {
                            Text($0)
                                .foregroundColor(.black)
                        }
                    })
                    .background(tagsColor[tags.firstIndex(of: selectedTag)!])
                        .clipShape(Capsule())
                        .frame(width: 100, height: 50)
                    }
                    }.frame(width: 100, height: 20)
                    Button(action: {
                        if self.description.isEmpty {
                            TaskModel.defaults.createNewTask(name: self.name)
                        } else {
                            TaskModel.defaults.createNewTask(name: self.name, text: self.description)
                        }
                        self.name = ""
                        self.description = ""
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Text("Сохранить")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color.red)
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .offset(y: 25)

                }
            }
            Spacer()
        }
    }
}

struct EditorTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditorTaskView()
    }
}
