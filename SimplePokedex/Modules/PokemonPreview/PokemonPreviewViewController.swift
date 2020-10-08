//
//  PokemonPreviewViewController.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

class PokemonPreviewViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: LoaderView!
    @IBOutlet private var errorView: UIView!
    
    var viewModel: PokemonPreviewViewModelType!
    
    private lazy var pageController: SpriteListViewController = {
        return children.first as! SpriteListViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PokemonCharacteristicTableViewCell.nib, forCellReuseIdentifier: PokemonCharacteristicTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        
        title = viewModel.output.pokemonName
        viewModel.delegate = self
        viewModel.input.reload()
    }
    
    @IBAction func refresh() {
        viewModel.input.refresh()
    }
    
    fileprivate func updateSprites() {
        
        pageController.sprites = viewModel.output.sprites
    }
}

extension PokemonPreviewViewController: PokemonPreviewViewModelDelegate {
    func dataLoading(isFinished: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = isFinished
            if isFinished {
                self.errorView.isHidden = self.viewModel.output.characteristicsCount() > 0
                self.tableView.reloadData()
                self.updateSprites()
            }
        }
    }
}

extension PokemonPreviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.characteristicsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCharacteristicTableViewCell.reuseIdentifier) as!  PokemonCharacteristicTableViewCell
        
        let characteristic = viewModel.output.characteristic(at: indexPath.row)
        cell.configure(with: characteristic)
        
        return cell
    }
    
    
}
