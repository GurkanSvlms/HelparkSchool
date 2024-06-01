//
//  CoreDataManager.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 31.08.2023.
//

import CoreData

class CoreDataManager : ObservableObject{
    static let shared = CoreDataManager()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HelparkIOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getOnboardingStatus() -> Bool {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<SplashEntity> = SplashEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let splashEntity = results.last {
                return splashEntity.isFirstTime
            } else {
                // Varsayılan değer
                return false
            }
        } catch let error {
            print("Failed to fetch data: \(error)")
            return false 
        }
    }

    
    func setOnboardingStatus(isFirstTime: Bool) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<SplashEntity> = SplashEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let splashEntity = results.first {
                splashEntity.isFirstTime = isFirstTime
                try context.save()
            }
        } catch {
            fatalError("Failed to update data: \(error)")
        }
    }
    
    func getUserId() -> String {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserIdEntity> = UserIdEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let userIdEntity = results.last {
                return userIdEntity.userId ?? "0"
            } else {
                // Varsayılan değer
                return "0"
            }
        } catch let error {
            print("Failed to fetch data: \(error)")
            return "0"
        }
    }

    
    func setUserId(userId: String) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserIdEntity> = UserIdEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let userIdEntity = results.first {
                userIdEntity.userId = userId
                try context.save()
            }
        } catch {
            fatalError("Failed to update data: \(error)")
        }
    }
}
