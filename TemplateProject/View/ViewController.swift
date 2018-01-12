//
//  ViewController.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 12/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataSource = DataSource()
    
    lazy var viewModel : ViewModel = {
        let viewModel = ViewModel(dataSource: dataSource)
        return viewModel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

protocol DataSourceProtocol : class {
    var data: [AnyObject] { get set }
}

class DataSource : DataSourceProtocol {
    var data: [AnyObject] = []
}

struct ViewModel {
    
    weak var dataSource : DataSourceProtocol?
    
    func fetchData() {
        
    }
}
