//
//  Router.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import UIKit

struct Router {
    
    private enum StoryboardName: String {
        case preview = "PokemonPreview"
    }
    
    static func preview(pokemon: String) -> UIViewController {
        let storyboard = UIStoryboard(name: StoryboardName.preview.rawValue, bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! PokemonPreviewViewController
        
        vc.viewModel = PokemonPreviewViewModel(pokemonName: pokemon)
        
        return vc
    }
}
