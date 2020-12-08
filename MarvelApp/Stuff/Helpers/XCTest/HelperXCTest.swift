import Foundation

func testsDetailViewIfNeeded() {
	#if XCTEST
	let characters = Bundle.parse(
		fileName: NetworkConstants.Mock.charactersResponse(Page(limit: 50, offset: 0)).path,
		type: CharacterResponse.self
	)
	let controller = CharacterDetailViewController.setup(with: (characters?.data?.results?[0])!)
	_ = controller.view
	#endif
}
