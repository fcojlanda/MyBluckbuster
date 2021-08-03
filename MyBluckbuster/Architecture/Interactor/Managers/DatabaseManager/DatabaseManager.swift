//
//  DatabaseManager.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 31/07/21.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    private var manager : DatabaseManager?
    private var managedContext : NSManagedObjectContext?
    private var appDelegate : AppDelegate?
    
    static var shared: DatabaseManager = {
        let instance = DatabaseManager()
        instance.appDelegate = UIApplication.shared.delegate as? AppDelegate
        instance.managedContext = instance.appDelegate!.persistentContainer.viewContext
        return instance
    }()
    
    func save(object: Movie)->Bool{
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext!)!
          
        let isntance = NSManagedObject(entity: entity, insertInto: managedContext)
        isntance.setValue(object.adult, forKeyPath: "adult")
        isntance.setValue(object.backdrop_path, forKeyPath: "backdrop_path")
        isntance.setValue(object.genre_ids, forKeyPath: "genre_ids")
        isntance.setValue(object.id, forKeyPath: "id")
        isntance.setValue(object.original_language, forKeyPath: "original_language")
        isntance.setValue(object.original_title, forKeyPath: "original_title")
        isntance.setValue(object.overview, forKeyPath: "overview")
        isntance.setValue(object.popularity, forKeyPath: "popularity")
        isntance.setValue(object.poster_path, forKeyPath: "poster_path")
        isntance.setValue(object.release_date, forKeyPath: "release_date")
        isntance.setValue(object.title, forKeyPath: "title")
        isntance.setValue(object.video, forKeyPath: "video")
        isntance.setValue(object.vote_average, forKeyPath: "vote_average")
        isntance.setValue(object.vote_count, forKeyPath: "vote_count")
        
        do {
            try managedContext!.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func getAll()->[NSManagedObject]{
        var results : [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do{
            results = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]
            
        }catch let error  as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return results
    }
}
