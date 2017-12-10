# SchoolPlatform

This project is a platform for interaction between students, teachers and administrative staff in a school environment.

## License
All SchoolPlatform source code is licensed under the MIT License. See [LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## Credit
- The layout of this app is based on the [SB Admin 2](https://github.com/BlackrockDigital/startbootstrap-sb-admin-2) template, Copyright (c) 2013-2017 Blackrock Digital LLC, provided under the MIT License.
