import UIKit

protocol RepoListDisplaying: AnyObject {
  func updateUI()
  func displayLoading(_ loading: Bool)
}

final class RepoListViewController: UIViewController {
  private let viewModel: RepoListViewModelContract
  
  private lazy var activityView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.backgroundColor = .white
      view.tintColor = .blue
      view.hidesWhenStopped = true
      view.isHidden = true
      return view
  }()
  
  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.delegate = self
    view.dataSource = self
    view.registerCell(cellType: ReposListTableViewCell.self)
    return view
  }()
  
  private lazy var rootView: RepoListView = {
    let view = RepoListView(frame: .zero,
                            tableView: tableView,
                            activityView: activityView)
    return view
  }()
  
  init(viewModel: RepoListViewModelContract) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    title = Constants.repoListTitle
  }
}

extension RepoListViewController: RepoListDisplaying {
  func updateUI() {
    tableView.reloadData()
  }
  
  func displayLoading(_ loading: Bool) {
    loading ? startLoading() : stopLoading()
  }
}

private extension RepoListViewController {
  func startLoading() {
    activityView.isHidden = false
    activityView.startAnimating()
  }
  
  func stopLoading() {
    activityView.stopAnimating()
  }
}

extension RepoListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.totalRepos
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row > viewModel.totalRepos {
      let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                               type: LoadingTableViewCell.self)
      return cell
    }
    let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                             type: ReposListTableViewCell.self)
    cell.setup(viewModel: .init(name: viewModel.reposInterface[indexPath.row].name,
                                url: viewModel.reposInterface[indexPath.row].url,
                                stars: String(format: Constants.starsFormat,
                                              "\(viewModel.reposInterface[indexPath.row].stargazers.totalCount)")))
    return cell
  }
}

extension RepoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    viewModel.willDisplayCell(index: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectCell(index: indexPath.row)
  }
}
