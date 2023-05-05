//
//  EntryViewModel.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import CoreData
import Combine

class EntryViewModel: ObservableObject {
    @Published var entries: [SleepRoutine] = []
    @Published var selectedDateEntry: [SleepRoutine] = []
    @Published var filledDate: [FilledDate] = []
    @Published var child: [Child] = []
    @Published var music: [Music] = []
    @Published var progress: [Progress] = []
    
    init() {
        initializeProgress()
        initializeChild()
        initializeMusic()
        getEntries()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataManager.shared.mainContext
        do {
            try moc.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func getEntries() {
        let fetchRequest: NSFetchRequest<SleepRoutine> = SleepRoutine.fetchRequest()
        let fetchRequestProgress: NSFetchRequest<Progress> = Progress.fetchRequest()
        let fetchRequestChild: NSFetchRequest<Child> = Child.fetchRequest()
        let fetchRequestFilled:NSFetchRequest<FilledDate> = FilledDate.fetchRequest()
        let fetchRequestMusic:NSFetchRequest<Music> = Music.fetchRequest()
        
        let moc = CoreDataManager.shared.mainContext
        do {
            entries = try moc.fetch(fetchRequest)
            progress = try moc.fetch(fetchRequestProgress)
            child = try moc.fetch(fetchRequestChild)
            filledDate = try moc.fetch(fetchRequestFilled)
            music = try moc.fetch(fetchRequestMusic)
            
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getOneEntry(date: Date) -> SleepRoutine? {
        let context = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<SleepRoutine> = SleepRoutine.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", "\(date.formatted(date: .abbreviated, time: .omitted))")
        
        do {
            let object = try context.fetch(fetchRequest).first
            return object
        } catch {
            return nil
        }
    }
    
    func createEntry(date: Date, bedTime: Date, distance: String) {
        let item = SleepRoutine(bedTime: bedTime, date: date.formatted(date: .abbreviated, time: .omitted), distance: distance)
        entries.append(item)
        filledDate.append(FilledDate(date: date))
        saveToPersistentStore()
    }
    
    func initializeChild() {
        if child.isEmpty {
            let item = Child(name: "", bedTime: Date())
            
            child.append(item)
            saveToPersistentStore()
        }
    }
    
    func saveToChild(entry: Child, name: String, bedTime: Date) {
        entry.name = name
        entry.bedTime = bedTime
        saveToPersistentStore()
    }
    
    func initializeProgress() {
        
        if progress.isEmpty {
            let item = Progress(currentStageIndex: 0, maxStageIndex: 0, onboardingCompleted: false)
            
            progress.append(item)
            saveToPersistentStore()
        }
        
    }
    
    func completeOnboarding(entry: Progress) {
        entry.onboardingCompleted = true
        saveToPersistentStore()
    }
    
    func editProgress(entry: Progress, currentStageIndex: Int, maxStageIndex: Int) {
        entry.currentStageIndex = Int16(currentStageIndex)
        entry.maxStageIndex = Int16(maxStageIndex)
        saveToPersistentStore()
    }
    
    func initializeMusic() {
        if music.isEmpty {
            let item = Music(selectedSong: "", lastDate: Date())
            
            music.append(item)
            saveToPersistentStore()
        }
    }
    
    func changeMusic(entry: Music, lastDate: Date, selectedSong: String) {
        entry.lastDate = lastDate
        entry.selectedSong = selectedSong
//        print(entry)
        saveToPersistentStore()
    }
}
