# RandomUserApp
[![Build Status](https://app.bitrise.io/app/440a3456b9b115e7/status.svg?token=oSdSDrKk9RKE9pHJIRZH2A&branch=master)](https://app.bitrise.io/app/a7a65dc277b222bc)
[![codecov.io](https://codecov.io/gh/ignaciohugog/RandomUserApp/branch/master/graphs/badge.svg?token=xOHOsq7exv)](https://codecov.io/gh/ignaciohugog/randomPerson/branch/master)
# Features

- [x] Users Listing 
- [x] Users Search 
- [x] User Detail
- [x] User persistence

# Technical Details

## Architecture
The architecture was based on VIPER and strongly influenced by the SOLID principles.
- **View**: displays what it is told to by the Presenter and relays user input back to the Presenter.
- **Interactor**: contains the business logic as specified by a use case.
- **Presenter**: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
- **Entity**: contains basic model objects used by the Interactor.
- **Routing**: contains navigation logic for describing which screens are shown in which order.
- **Builder**: Builder class used to build the complete module.

## Dependencies

### Kingfisher
Swift library for downloading and caching images from the web.

### Alamofire
Used to perform network requests.

### PromiseKit
Used for simplify asynchronous programming.

# Requirements
- [x] XCODE 11
- [x] Swift 5
- [x] iOS 11.0

# Installation
1. Clone the repository
```https://github.com/ignaciohugog/RandomUserApp.git```
2. Install dependencies:
```cd RandomUserApp```
```pod update```
```pod install```

2. open RandomUserApp.xcworkspace
3. Run the tests ```CTRL+U```
3. Also build and run ```CTRL+R```

# Author
Ignacio Gómez, ignaciohugog@gmail.com
