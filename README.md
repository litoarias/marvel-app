# marvel-app

## Description

The application is made using the [Marvel API](https://developer.marvel.com), in order to explain how to use MVVM, the main concepts are:

* `MVVM` Model-View-ViewModel architecture
* `Environment` Multiple environments setup
* `Unit Testing` ViewModel test cases
* `Third party libraries`:
	* `Alamofire` The Network layer
	* `Sourcery` Secure credential handling
	* `PromiseKit` More readable syntax and simplify asynchronous programming
	* `PagedLists` Class for manage an infinite scrolling

## Run Requirements

* Xcode 10+
* iOS 11+

### Build and run the application

1. Install Pods

```bash
pod install
```

 2. Create a `env-vars.sh` file inside the project directory and add your `public` and `private` key there as follows:

``` bash
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```	

> `Sourcery` will generate a configuration file with these credentials, on the `Environment.generated.swift` file.

3. **Build project** (maybe need to build on two times) and a new file **will be generated on `Environment`** folder.

The application should be compiling! 🍺🍻
