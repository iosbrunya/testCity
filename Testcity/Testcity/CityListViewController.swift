//
//  CityListViewController.swift
//  Testcity
//
//  Created by Brunya on 01.04.2021.
//

import UIKit

final class CityListViewController: UIViewController {
    let model = CityListModelController()
    
    
    private(set) lazy var cityListView = view as! CityListView
    
    
    
    override func loadView() {
        view = CityListView(frame: UIScreen.main.bounds, style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Города"
        navigationController?.navigationBar.prefersLargeTitles = true
        cityListView.dataSource = self
        cityListView.delegate = self
        
        
        
        let progressBar = UIRefreshControl(frame: .init(
                                            origin: .init(
                                                x: UIScreen.main.bounds.width / 2.0 - 25.0,
                                                y: UIScreen.main.bounds.height / 2.0 - 25.0),
                                            size: .init(width: 50.0, height: 50.0)))
        cityListView.backgroundView = progressBar
        
        progressBar.beginRefreshing()
        model.loadWeatherInfo { _ in
            DispatchQueue.main.async {
                progressBar.endRefreshing()
                progressBar.removeFromSuperview()
                self.cityListView.reloadData()
            }
        }
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CityListViewCell else {
            preconditionFailure("We use only `CityListViewCell` class")
        }
        
    
        let city = model.cities[indexPath.item]
        guard let weatherInfo = model.weatherInfo[city.name] else { return cell }
        cell.configure(name: city.name,
                       pressure: weatherInfo.fact.pressureMM,
                       humidity: weatherInfo.fact.humidity,
                       wind: weatherInfo.fact.windSpeed,
                       feelsLike: weatherInfo.fact.feelsLike)
            
        return cell
    }
}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
}

// ecc52302-c850-495d-a05b-9ffc176e4e92



/*

CPU
    --- ------- ----- ---
    -- ------ ---- -- ---

 
 
 DispatchQueue Main Thread1(Main) UI -*-*-*-*-*- &- - - --  - - -
 
 Thread2 --*-*-*- &- - - - - - - - - -
 
 Process ( Thread, ...)

 
 
 
 
 */



