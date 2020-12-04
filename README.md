# marvel-app

## Description

The application is made using the [Marvel API](https://developer.marvel.com), in order to explain how use MVVM, PromiseKit, Sourcery generator, Unit test and Alamofire in Swift.

## Run Requirements

* Xcode 10

## Build and run the application

You should name the root folder when cloning project it like root project folder `MarvelApp`, in order to allow Sourcery to make the magic!

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `env-vars.sh` file inside the project directory and add your `public` and `private` key there as follows:

``` bash
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

Before compiling Swift files, Sourcery will generate a configuration file with these credentials, first, you must delete the current file on Xcode (the file with a red name), drag & drop from finder the new generated file.