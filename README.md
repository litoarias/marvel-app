# marvel-app

## Description

The application is made using the [Marvel API](https://developer.marvel.com), in order to explain how use MVVM, PromiseKit, Sourcery generator, Unit test and Alamofire in Swift together.

## Run Requirements

* Xcode >10.x
* iOS >11

## Third party Dependencies 

The first step is install the dependencies.

### Cocoapods

I prefer to use cocoapods for the simplicity of usage, pelase run below command on terminal:

```bash
pod install
```

For this example I'm using next libraries:

```ruby 
pod 'Alamofire'
pod 'PromiseKit/CorePromise'
pod 'Sourcery'
```

## Build and run the application

The security is important, and the api keys should be generated with your marvel user.

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) you need to create a `env-vars.sh` file inside the project directory and add your `public` and `private` key there as follows:

``` bash
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

Then you can go to Xcode and **find** a file located on `MarvelApp/Stuff/Environment/Environment.generated.swift` with **the red text colour**, and you must **remove it** to be able to compile project.

> `Sourcery` will generate a configuration file with these credentials, but take in account when you compiling the project, the `Environment.generated.swift` **file is missed**, and `Sourcery` needs compile the project without errors to be able to generate the `Environment.generated.swift` file. 

Because of that, you need to **comment** the next lines of code on file `APIRouter.swift`:

```swift
private var parameters: Parameters? {
	switch self {
	case .getCharacters(let limit, let offset):
		return [
			NetworkConstants.ParameterKey.limit.rawValue: limit,
			NetworkConstants.ParameterKey.offset.rawValue: offset,
//				NetworkConstants.ParameterKey.apikey.rawValue: credentials.publicApiKey,
//				NetworkConstants.ParameterKey.ts.rawValue: credentials.timestamp,
//				NetworkConstants.ParameterKey.hash.rawValue: credentials.hash
		]
	}
}
```

Now you can **build project** and a new file **will be generated on `Environment`** folder, you can found it on your **Finder** and you'll drag and drop on Xcode, the file should be placed in `Environment` folder of the project, then you can **uncomment** the code on file `APIRouter.swift`.

The application should be compiling! 🍺🍻
