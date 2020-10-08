## Architecture

Project consist of two modules:
- `PokemonAPI` - wrapper of API from https://pokeapi.co
- `SimplePokedex` - application for displaying pokemons and their stats

Such kind of division allows to split UI and API calls to reduce dependencies.

Data obtained from PokemonAPI framework mapped into internal models in application. Also, application allows search of pokemons by name in currently loaded pokemons.

Error processing is simplified to reduce time spent on development.

## Caching

All data loaded from network cached inside application for offline usage and reduction of network requests. Data obtained from API saved into database via CoreData. Pokemon images cached via NSCache.

## Test coverage

Only critical parts covered by UnitTests.

## TODO
- [ ] Fully tested
- [ ] Fully commented
- [ ] Updated error processing
