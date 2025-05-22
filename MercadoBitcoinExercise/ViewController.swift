import UIKit

protocol ExchangesViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showExchanges(_ exchanges: [ExchangeViewModel])
    func showError(_ message: String)
}

final class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ExchangeTableViewCell.self, forCellReuseIdentifier: "ExchangeCell")
        return table
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var exchanges: [ExchangeViewModel] = []
    private var presenter: ExchangePresenterProtocol
    
    init(presenter: ExchangePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupRefreshControl()
        presenter.configure(with: self)
        presenter.viewDidLoad()
    }
    
    private func setup() {
        title = "Exchange List"
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshControlValueChanged() {
        presenter.pullToRefresh()
    }
}

extension ViewController: ExchangesViewProtocol {
    func showLoading() {
        loadingIndicator.startAnimating()
        errorView.isHidden = true
        tableView.isHidden = true
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    
    func showExchanges(_ exchanges: [ExchangeViewModel]) {
        self.exchanges = exchanges
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        loadingIndicator.stopAnimating()
        errorView.isHidden = true
        tableView.isHidden = false
    }
    
    
    func showError(_ message: String) {
        errorView.configure(error: message) { [weak self] in
            self?.presenter.onRetry()
        }
        errorView.isHidden = false
        tableView.isHidden = true
        loadingIndicator.stopAnimating()
        tableView.refreshControl?.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeCell", for: indexPath) as? ExchangeTableViewCell else {
            return UITableViewCell()
        }
        
        let exchange = exchanges[indexPath.row]
        cell.configure(with: exchange)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exchange = exchanges[indexPath.row]
        presenter.didSelectExchange(exchange)
    }
}
