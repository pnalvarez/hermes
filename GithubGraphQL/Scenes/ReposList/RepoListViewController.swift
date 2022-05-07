import UIKit

protocol RepoListDisplaying: AnyObject {
  func updateUI()
}

final class RepoListViewController: UIViewController {
  private let viewModel: RepoListViewModelContract
  
  init(viewModel: RepoListViewModelContract) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    viewModel.viewDidLoad()
  }
}

extension RepoListViewController: RepoListDisplaying {
  func updateUI() {
    #warning("TO DO")
  }
}
