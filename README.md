# ftf_usb

Example project how to communicate between two separe flutter applications (Android and MacOS) by TCP/IP connection using ADB.

## Steps to make this example work

### Setup your physival development Android device

- Enable developer mode
- Enable USB debugging
- Connect device to development machine throught USB

### Update Client Code with Correct IP

List your development machine local IP address

```bash
ifconfig | grep inet
```

Look for the inet address under en0 or the interface connected to your network. Once you have it grab that and change the `kLocalMachineIP` variable value.

```dart
const kLocalMachineIP = '<your_machine_ip>';
```

### adb

Port forward our TCP/IP connection using adb.

```bash
adb forward tcp:8000 tcp:8000
```

To ensure that it works you can use this command

```bash
adb forward --list
```

In case you don't have adb just snatch it using brew

```bash
brew install android-platform-tools
```

### Run the apps

Now in two separete terminals run

```bash
flutter run
```

and

```bash
flutter run -d macos
```

Once clicking on plus button you should see the data flow in both terminal windows.
