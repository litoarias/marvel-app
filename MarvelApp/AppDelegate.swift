
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let controller = ViewController()
		let navigation = UINavigationController(rootViewController: controller)
		
		window?.rootViewController = navigation
		window?.backgroundColor = .white //UIColor("#2A2C45")
		window?.makeKeyAndVisible()
		
		return true
	}
}

