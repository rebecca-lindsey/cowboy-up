# Cowboy Up

Cowboy Up is a Sinatra MVC application that allows you to create and enjoy virtual horses and view all of the other horses in the stable.

## Installation

- Ensure that you have [Ruby](https://www.ruby-lang.org/en/downloads/) installed properly
- Begin by cloning the repository and navigating to the download location
- Make sure that you have all necessary gems by running:

```
bundle install
```

## Usage

### Starting the program

To start the application:

```
rackup
```

Navigate in your web browser to the address listed in:

```
2020-12-11 15:43:47 -0500 Listening on localhost:9292, CTRL+C to stop
```

In this case, it would be `localhost:9292`

### How to use the program

- The application opens on the homepage. From here, you may use the buttons to create a new user or sign in if you already have a user.
- Upon successfully signing in or registering, you will be brought to a page listing all of your horses(none, if you are a new user)
- You may click on any of these horses or you use the buttons to navigate to Stable, Create New Horse, or Logout.
  - If you click on a horse, you will be given the option to edit or delete the horse
  - Stable: You will be able to view all the horses and owners that exist in the database
  - Create New Horse: You will be taken to a page to create a new horse
  - Logout: You will be logged out of Cowboy Up

## License

The program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)

## Collaborating

Pull Requests are welcome on [GitHub](https://github.com/rebeccahickson/cowboy-up). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://github.com/cjbrock/worlds-best-restaurants-cli-gem/blob/master/contributor-covenant.org) code of conduct.
