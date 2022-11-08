import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        configureWindow()
        launchCheckingNetworkConnection()
        return true
    }
}

// MARK: - Private Methods

private extension AppDelegate {
    
    func configureWindow() {
        let rootViewController = MainViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.overrideUserInterfaceStyle = .light
    }
    
    func launchCheckingNetworkConnection() {
        NetworkMonitor.shared.startMonitoring()
    }
}
