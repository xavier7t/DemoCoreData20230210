//
//  ContentView.swift
//  DemoCoreData20230210
//
//  Created by Xavier on 2/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Group {
                // when no notes found, display a hint message
                if vm.notes.count == 0 {
                    Text("No note saved yet. Press the New button to create one")
                        .bold()
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(vm.notes) { note in
                            // Note Row
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        
                                        // title
                                        Text(note.title ?? "")
                                            .font(.title3)
                                            .lineLimit(1)
                                            .bold()
                                            
                                        // date
                                        Text(note.createdAt?.asString() ?? "")
                                            .lineLimit(1)
                                    }
                                    
                                    // body preview
                                    Text((note.body ?? ""))
                                        
                                        .lineLimit(1)
                                }
                                Spacer()
                                
                                // fav icon
                                Image(systemName: note.isFavorite ? "star.fill" : "star")
                                    .onTapGesture {
                                        vm.toggleFav(note: note)
                                    }
                                    .foregroundColor(note.isFavorite ? .yellow : .secondary)
                            }
                            
                            // delete option on swipe
                            .swipeActions {
                                Button(role: .destructive) {
                                    vm.deleteNote(note: note)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                // new note button
                Button("New") {
                    vm.showAlert = true
                }
                .alert(vm.noteTitle, isPresented: $vm.showAlert, actions: {
                    TextField("Title", text: $vm.noteTitle)
                    TextField("Body", text: $vm.noteBody)
                    Button("Save", action: { vm.createNote() })
                    Button("Cancel", role: .cancel, action: { vm.clearStates() })
                }) {
                    Text("Create a new note")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//extension ContentView {
//    private func testCRUD() {
//        print("loading...😊😊😊😊😊")
//        let controller = PersistenceController.shared
//        print("# of notes:", controller.read().count)
//        controller.create(title: "test", body: "note body", isFavorite: true)
//        controller.create(title: "test2", body: "note body", isFavorite: false)
//        print("# of notes should be 2: ", controller.read().count)
//        print("# of filtered notes should be 1: ", controller.read(predicateFormat: "title == 'test2'").count)
//        let notes = controller.read()
//        for note in notes {
//            controller.delete(note)
//        }
//        print("# of note should be 0: ",controller.read().count)
//    }
//}
