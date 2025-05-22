import Foundation

protocol ConfigurationManagerProtocol {
    func coinApiKey() -> String
}

final class ConfigurationManager: ConfigurationManagerProtocol {
    static let shared = ConfigurationManager()
    private init() {}
    
    private lazy var configPlist: [String: Any] = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("Config.plist not found")
        }
        return plist
    }()
    
    func coinApiKey() -> String {
        guard let key = configPlist["COINAPI_KEY"] as? String else {
            fatalError("COINAPI_KEY not found in Config.plist")
        }
        return key
    }
}
