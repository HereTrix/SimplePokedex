//
//  PokemonListViewController.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var loaderView: LoaderView!
    
    fileprivate let minCellSize: CGFloat = 100
    
    lazy var viewModel: PokemonListViewModelType! = PokemonListViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PokemonListCollectionViewCell.nib, forCellWithReuseIdentifier: PokemonListCollectionViewCell.reuseIdentifier)
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        viewModel.input.displayedItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.output.item(at: indexPath.row)
        
        let preview = Router.preview(pokemon: item.name)
        navigationController?.pushViewController(preview, animated: true)
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCollectionViewCell.reuseIdentifier, for: indexPath) as! PokemonListCollectionViewCell
        
        let item = viewModel.output.item(at: indexPath.row)
        cell.configure(with: item)
        
        return cell
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func removedItem(at index: Int) {
        collectionView.performBatchUpdates {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    func addedItem(at index: Int) {
        collectionView.performBatchUpdates {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.insertItems(at: [indexPath])
        }
    }
    
    func updatedItem(at index: Int) {
        collectionView.performBatchUpdates {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }

    }
    
    func updatedItems() {
        collectionView.reloadData()
    }
    
    func dataLoading(isFinished: Bool) {
        loaderView.isHidden = isFinished
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filter = ""
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
