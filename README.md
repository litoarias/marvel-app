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

## Build and run the application

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `env-vars.sh` file inside the project directory and add your `public` and `private` key there as follows:

``` bash
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

Before compiling Swift files, Sourcery will generate a configuration file with these credentials, first, you must delete the current file on Xcode (the file with a red name), drag & drop from finder the new generated file.