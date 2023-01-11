import UIKit
import PlaygroundSupport

class activityViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemYellow
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        
        view.addSubview(label)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24)
        ])
        
        
        activityIndicator.startAnimating()
        label.text = "Loading operation"
        operation()
    }
    
    func operation() {
        let currentQueue = OperationQueue.current
        let operation = BlockOperation {
            sleep(8)
            // Changes in the interface must be called from main operation queue
            OperationQueue.main.addOperation { [weak self] in
                self?.label.text = "Operation finished"
                self?.activityIndicator.stopAnimating()
            }
        }
        
        currentQueue?.addOperation(operation)
    }
}


PlaygroundPage.current.liveView = activityViewController()
