Currently just outputs a list of matching people from your MacOS contacts.
Eventually will be a CLI for managing contacts.

### Build

```
swift build --configuration release
```

### Install

```
sudo cp -f .build/release/Peeps /usr/local/bin/peeps
```

### Use

```
$ peeps john
```

```
1. Jane Johnson
2. John Jacob Jingleheimer Schmidt
```
