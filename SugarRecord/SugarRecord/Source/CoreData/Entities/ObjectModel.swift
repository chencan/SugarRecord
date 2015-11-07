import Foundation
import CoreData

// MARK: - CoreData.ObjectModel

public extension CoreData {
    
    /**
     It represents a CoreData Object Model
     
     - Named:  With the provided name. The model must be in the Main Bundle with the name NAME.xcdatamodel
     - Merged: Merging all the data models in the app bundle
     - URL:    Referenced by the provided URL
     */
    public enum ObjectModel: CustomStringConvertible {
        case Named(String)
        case Merged([NSBundle]?)
        case URL(NSURL)
        
        /**
         Returns the NSManagedObjectModel from the enum
         
         - returns: managed object model
         */
        func model() -> NSManagedObjectModel? {
            switch self {
            case .Merged(let bundles):
                return NSManagedObjectModel.mergedModelFromBundles(bundles)
            case .Named(let name):
                return NSManagedObjectModel(contentsOfURL: NSBundle.mainBundle().URLForResource(name, withExtension: "xcdatamodel")!)
            case .URL(let url):
                return NSManagedObjectModel(contentsOfURL: url)
            }
        }
        
        public var description: String {
            get {
                switch self {
                case .Named(let name): return "NSManagedObject model named: \(name) in the main NSBundle"
                case .Merged(_): return "Merged NSManagedObjec models in the provided bundles"
                case .URL(let url): return "NSManagedObject model in the URL: \(url)"
                }
            }
        }
    }
    
}