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

Fetch all your contacts matching "jen":

```
$ peeps jen
```

If only one match is found, peeps will display it:

```
Found 1 peep.

Jenny Schneider
---------------
iPhone  (555) 867-5309
Other   (555) 606-0842

Work    jenny8675309@gmail.com

Home    1234 Main St
        Anytown, CA 12345
```

If multiple matches are found, peeps will display a list of matches for you to choose.

```
Found 3 peeps.

1. Jenny Schneider
2. Jennifer Universal
3. Ron O'Jen

Who to peep? [1-3]: _

```
