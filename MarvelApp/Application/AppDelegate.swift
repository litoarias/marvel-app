import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let navigation = UINavigationController(rootViewController: CharacterListViewController.setup())
		
		window?.rootViewController = navigation
		window?.backgroundColor = .white
		window?.makeKeyAndVisible()
		
		testsDetailViewIfNeeded()
		
		return true
	}
}
