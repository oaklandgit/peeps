Currently just outputs a list of matching people from your MacOS contacts.
Eventually will be a CLI for managing contacts.

### Requires

MacOS

### Build

Build from source:

```
swift build --configuration release
```

### Install

Copy it into your path:

```
sudo cp -f .build/release/Peeps /usr/local/bin/peeps
```

### Use

Fetch all your contacts with "jen" in the name, and show all their phone numbers.

```
$ peeps jen -p

Jenny Schneider
===============
iPhone: (555) 867-5309
Other: (555) 606-0842

Jennifer Universal
==================
iPhone: (212) 664-7665
```
