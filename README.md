# marvel-app

## Description

The application is made using the [Marvel API](https://developer.marvel.com), in order to explain how use MVVM, PromiseKit, Sourcery generator, Unit test and Alamofire in Swift.

## Run Requirements

* Xcode 10

## Third party Dependencies 

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

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `env-vars.sh` file inside the project directory and add your `public` and `private` key there as follows:

``` bash
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

> ### Important
> `Sourcery` will generate a configuration file with these credentials, but take in account when you're compiling the project, the `Environment.generated.swift` file is missed, and `Sourcery` needs compile the project without errors to be able to generate the `Environment.generated.swift`. Because of that, you need to comment the next lines of code on file `APIRouter.swift`, then the file will be generated and you'll drag and drop on Xcode, the file should be placed in `Environment` folder of the project, now you can uncomment the code. :

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