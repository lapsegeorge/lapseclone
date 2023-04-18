# A Journal by Lapse clone!

This project focuses on matching Journal's UI to (hopefully) show my attention to detail!

Built using MVVM and SwiftUI.

<img width="358" alt="Screenshot 2023-04-17 at 23 48 13" src="https://user-images.githubusercontent.com/85873101/232632737-19409df2-dc92-4586-8a50-d3860f4331c5.png"><img width="361" alt="Screenshot 2023-04-17 at 23 42 48" src="https://user-images.githubusercontent.com/85873101/232633043-88dab3db-d141-4ac7-a6d6-96febea04b68.png">



## Installation

1. Open the LapseClone.xcworkspace file found in LapseClone/LapseClone.xcworkspace. This is necessary when using CocoaPods to ensure dependencies are resolved correctly
2. Xcode -> File -> Packages -> Resolve Package Versions
3. Build and run

## My thought process

Briefly, the clone is of Journal's tab bar and Inbox screen, and includes:
- Designs based on those found via the Journal app walkthrough video
- Consuming an API
- Displaying the resulting data alongside some additional mock data
- Unit and integration tests

Although my plan was largely to create a clone of the Inbox screen, I also wanted to demonstrate consuming an API. For this, I used an API provided by https://lldev.thespacedevs.com/2.2.0/swagger/#/ to populate the user photos on the Inbox screen. Their **/astronauts** endpoint provided profile photo data we could use to achieve this. The remainder of the screen is created using mock data.

After deciding on an app architecture (detailed in the App Architecture section below) I selected two dependencies to use, both installed via their recommended installation method, CocoaPods:

- [SwiftGen](https://github.com/SwiftGen/SwiftGen) - to ensure our images, colours and localisable strings are type-safe, and accessible via automatically generated Asset and L10n enums respectively.
- [SwiftLint](https://github.com/realm/SwiftLint) - to enforce community-recognised Swift styling and conventions across the project.

The Xcode project was created using a SwiftUI interface and lifecycle, as this most closely matches the route I believe Lapse are taking!

My first task was to create a basic, protocol-based networking layer, APIServiceProtocol, using [Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html). Being protocol-based allows us to ‘blueprint’ data services we may create in the future, ensuring a single source of truth for network requests. Concurrency’s Async/Await was used primarily to simplify testing asynchronous code (which often comes with a lot of bloat, (think Expectations in XCTest), although the non-closure based syntax is also cleaner and guarantees the result is handled in a single downstream call site.

After creating our LapseService to fetch from **/astronauts**, I created LapseRepository to encapsulate logic for translating domain layer information/state into something that can be used to request from our remote (or local) database.

A Configurations.plist was used to store our https://lldev.thespacedevs.com/ base url environment variable.

Following this, I:
- Created a custom TabContainerView to mimic Journal's tab bar
- Built a basic list displaying Inbox items, via InboxView and InboxViewModel
- Added a bonus screen shown when selecting a different tab or tapping on one of InboxView's navigation items

## App architecture

The app was built using MVVM as the design pattern of choice. My usual go-to in UIKit projects is MVVM-C, although as navigation is built into the View in SwiftUI, adding a Coordinator felt like over-engineering a solution and possibly an unnecessary abstraction.

I’ve previously worked with VIPER, which I did enjoy, but the additional Interactor layer became really cumbersome to make changes to and as a team we found that it ended up affecting development speed. I find that MVVM is a good balance of testability, abstraction and promotes single responsibility.

![App Architecture](https://user-images.githubusercontent.com/85873101/232634991-d4054423-317e-4251-8c8f-81d84e82bcfd.jpg)

As illustrated above, the architecture is heavily protocol-based to improve testability - we can easily inject a mocked version of the Repository for example, which we do to test our InboxViewModel behaves correctly when receiving (mock) data.

It’s also worth noting that the arrows are in a single direction - of the higher-level modules, ensuring dependency inversion. The View Model does not hold knowledge about the View, the Repository does not hold knowledge about the View Model, and the Service (database) does not hold knowledge about the Repository.

The local database is shown for illustration purposes.

I use the repository pattern to ensure domain objects remain persistence agnostic.

Finally, a project-wide MARK structure is used to improve readability/speed.

## If I had more time/Future considerations

- The UI would've been built with all supported devices in mind - for the purpose of this demo I designed for iPhone 14 Pro Max.
- Errors would not be printed to console - we should prefer notifying the user when errors occur, as well as sharing details about the error with our observability platform (i.e. Sentry).
- Loading states - we should ensure users are aware when an action is in progress, as per the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/loading/)
- Accessibility support - although I have added an accessibilityLabel to the camera tab bar item
- Project modularisation - not something I’ve tackled before, but if I had more time I would’ve modularised the project as I like the idea of isolating development into packages to avoid conflicts and improve compile time!

## Notes
- Usually I will break changes down into small commits, however this task was created locally before adding to source control.
- I would not store Configurations.plist in source control. Due to its sensitive nature, we may decide to store it as a GitHub Secret in our repository, or use a service such as Google Cloud’s Secret Manager via Firebase Cloud Functions to fetch configurations securely at runtime.
- I have added the Pods folder to source control to allow you to build the project without any configuration, although usually I would add the /Pods folder to gitignore.

## Conclusion
I hope this shows that, although I have been working on a UIKit-based app, I am able to quickly adapt to the challenge at hand.

I also really enjoyed building this! Look forward to hopefully discussing it with you.

George
