//
//  CoreDataManager.swift
//  FaceDoct
//
//  Created by Mina Malak on 02/07/2021.
//

import CoreData

class CoreDataManager{
    
    public static let shared : CoreDataManager = CoreDataManager()
    
    private init(){}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context : NSManagedObjectContext!{
        return persistentContainer.viewContext
    }
    
    //MARK:- Save CoreData
    private func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }
            catch let error{
                print("Can't save context:",error)
            }
        }
    }
    
    //MARK:- Delete CoreData
    func delete(_ obj: NSManagedObject?) {
        guard let deleteObjc = obj else { return }
        context.delete(deleteObjc)
        print("Deleted Succesed")
        saveContext()
    }
    
    func delete(_ obj: [NSManagedObject]?) {
        guard let deleteObjc = obj else { return }
        deleteObjc.forEach({context.delete($0)})
        print("Deleted Succesed")
        saveContext()
    }
    
    //MARK:- Add Item
    func addArticle(article: Article){
        let art: FavoriteArticles! = NSEntityDescription.insertNewObject(forEntityName: "FavoriteArticles", into: context) as? FavoriteArticles
        art.source = article.source?.name
        art.author = article.author
        art.title = article.title
        art.desc = article.articleDescription
        art.url = article.url
        art.urlToImage = article.urlToImage
        art.publishedAt = article.publishedAt
        art.date = article.date
        art.content = article.content
        
        saveContext()
        print(getArticles() as Any)
    }
    
    //MARK:- Get Items
    func getArticles()->([FavoriteArticles]?){
        do{
            let items = try context.fetch(FavoriteArticles.fetchRequest())
            if !items.isEmpty{
                return (items)
            }
            return (nil)
        }
        catch let error{
            print("Can't Get articles",error)
            return (nil)
        }
    }
    
    
    //MARK:- Delete Items From CoreData
    func removeAllArticles(){
        do{
            let items = try context.fetch(FavoriteArticles.fetchRequest())
            delete(items)
        }
        catch let err {
            print("Error on creating/updating order", err)
            return
        }
    }
}
