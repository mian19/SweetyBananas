
import Foundation

class MemoryManager {
    
    private init() {}
    
    private static let instance = MemoryManager()
    
    static func shared() -> MemoryManager {
        return instance
    }
    
    func save(_ value: Any?, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func read(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
//    let userDefaultsManager = UserDefaultsManager.shared()
//    userDefaultsManager.setValue("John Smith", forKey: "userName")
//    let userName = userDefaultsManager.value(forKey: "userName") as? String ?? ""
    
    
}
