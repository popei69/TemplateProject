//
//  ViewController.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 12/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit
import Combine
import CombineDataSources

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView! 
    
    let viewModel = CurrencyViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "£ Exchange rate"
        self.bindViews()
        
        viewModel.reload.send(())
    }
    
    private func bindViews() {
        viewModel.$rates
            .bind(subscriber: self.tableView.rowsSubscriber(cellIdentifier: "CurrencyCell", cellType: CurrencyCell.self, cellConfig: { (cell, indexPath, currencyRate) in
                cell.currencyRate = currencyRate
            }))
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .sink { [weak self] message in 
                self?.showError(message)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Error handler
    
    private func showError(_ errorMessage: String?) {
        guard errorMessage?.isEmpty == false else { 
            return
        }
        
        // display error
        let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
