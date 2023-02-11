//
//  ViewModel.swift
//  DemoCoreData20230210
//
//  Created by Xavier on 2/10/23.
//

import Foundation

class ViewModel: ObservableObject {
    // save fetched notes for view loading
    @Published var notes: [Note] = []
    
    let dataService = PersistenceController.shared
    
    //states
    @Published var showAlert: Bool = false
    @Published var noteTitle: String = ""
    @Published var noteBody: String = ""
    @Published var noteIsFav: Bool = false
    
    init() {
        getAllNotes()
    }
    
    func getAllNotes() {
        notes = dataService.read()
    }
    
    func createNote() {
        dataService.create(title: noteTitle, body: noteBody, isFavorite: noteIsFav)
        getAllNotes()
    }
    
    func toggleFav(note: Note) {
        dataService.update(entity: note, isFavorite: !note.isFavorite)
        getAllNotes()
    }
    
    func deleteNote(note: Note) {
        dataService.delete(note)
        getAllNotes()
    }
    
    func clearStates() {
        noteTitle = ""
        noteBody = ""
        noteIsFav = false
    }
}
