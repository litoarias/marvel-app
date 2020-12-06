import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		var viewModel: CharacterListViewModel!
		#if MOCK || XCTEST
		viewModel = CharacterListViewModel(ClientMock())
		#else
		viewModel = CharacterListViewModel(Client())
		#endif
		
		let controller = CharacterListViewController(viewModel: viewModel)
		let navigation = UINavigationController(rootViewController: controller)
		
		window?.rootViewController = navigation
		window?.backgroundColor = .white
		window?.makeKeyAndVisible()
		
		return true
	}
}
