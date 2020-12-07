import UIKit

final class CharacterDetailViewController: UIViewController {

	init(viewModel: CharacterDetailViewModel, character: Character) {
		super.init(nibName: nil, bundle: nil)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
