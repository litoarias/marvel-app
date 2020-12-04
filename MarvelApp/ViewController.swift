
import UIKit
import Foundation
import PromiseKit
import Alamofire

class ViewController: UIViewController {
	let apiSession = Session()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		
		
		firstly {
			self.getCharacters()
		}.then { characters in
			self.sendSecondRequest()
		}.done {
			debugPrint($0)
		}.catch {
			debugPrint($0)
		}.finally {
			debugPrint("Finished")
		}
		
	}
	
	func getCharacters() -> Promise<CharacterRequest> {
		let (promise, seal) = Promise<CharacterRequest>.pending()
		#warning("DYNAMIC PARAMS PLEASE!")
		apiSession.request(.getCharacters(20, 0)).done { (characters: CharacterRequest) in
			seal.fulfill(characters)
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
	
	func sendSecondRequest() -> Promise<String> {
		let (promise, seal) = Promise<String>.pending()
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
			seal.fulfill(("Tu tutu utut utut ut!!"))
		}
		return promise
	}
	
}
