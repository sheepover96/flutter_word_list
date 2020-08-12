import UIKit
import Flutter
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class DictionaryServiceManager {
    private let AppleGlobalDomainName = "Apple Global Domain"
    private let DictionaryServicesKey = "com.apple.DictionaryServices"
    private let ActiveDictionariesKey = "DCSActiveDictionaries"

    private var globalDomain: [String : Any]? {
        return UserDefaults.standard.persistentDomain(forName: AppleGlobalDomainName)
    }

    private var dictionaryPreferences: [String : AnyObject]? {
        return self.globalDomain?[DictionaryServicesKey] as! [String : AnyObject]?
    }

    private var currentDictionaryList: [String]? {
        return self.dictionaryPreferences?[ActiveDictionariesKey] as! [String]?
    }

    private func setUserDictPreferences(_ activeDictionaries: [String]) {
        if var currentPref = self.dictionaryPreferences {
            currentPref[ActiveDictionariesKey] = activeDictionaries as AnyObject
            if var gDomain = self.globalDomain {
                gDomain[DictionaryServicesKey] = currentPref
                UserDefaults.standard.setPersistentDomain(gDomain, forName: AppleGlobalDomainName)
            }
        }
    }

    func lookUp(_ word : String, inDictionary dictionaryPath : String) -> String? {
        let currentPrefs = self.currentDictionaryList
        self.setUserDictPreferences([dictionaryPath])

        let range = CFRangeMake(0, word.utf16.count)
        let result = DCSCopyTextDefinition(nil, word as CFString, range)?.takeRetainedValue() as String?

        if let currentPrefs = currentPrefs {
            self.setUserDictPreferences(currentPrefs)
        }

        return result
    }
}
