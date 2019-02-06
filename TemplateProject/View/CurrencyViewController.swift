//
//  ViewController.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 12/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView! 
    
    let viewModel = CurrencyViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "£ Exchange rate"
        self.bindViews()
    }
    
    private func bindViews() {
    
        // bind data to tableview
        self.viewModel.rates
            .subscribeOn(MainScheduler.instance)
            .catchError { [weak self] error -> Observable<[CurrencyRate]> in
                self?.showError(error as? ErrorResult)
                return Observable.empty()
            }
            .bind(to: self.tableView.rx.items(cellIdentifier: "CurrencyCell", cellType: CurrencyCell.self)) { (row, currencyRate, cell) in
                
                cell.currencyRate = currencyRate
            }
            .disposed(by: disposeBag) 
    }
    
    // MARK: - UI
    
    private func showError(_ error: ErrorResult?) {
        
        // display error ?
        let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
