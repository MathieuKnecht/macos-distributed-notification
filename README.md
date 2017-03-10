# Issue with distributed notifications

Trying to develop a MacOS helper, a command line app executed in root mode, I encounter a strange behaviour from distributed notifications.

I try to send distributed notifications with **DistributedNotificationCenter** to the helper from another app running in user mode.

If the app is launched by XCode or shell command line in root mode, the helper receives notifications from the other app.
If the app is launched by a launch daemon, the helper does not receive notifications.


## Testing
### From XCode

1. Clone the repository
2. Open the project TestDistributedNotification.xcodeproj
3. Run target **Helper**, it is already configured to run in root mode (it will ask for admin password).
4. Then run target **Notifier**, it will send a distributed notification to the helper.
5. You should see a log in the Helper output:  

```
Helper: started ...  
Helper: receive command  
Helper: command: testCommand, argument: testArgument
``` 
It confirms that the helper received the distributed notification correctly.

Outputs are also logged in ```/var/log/DNHelper.log```

### From command line

1. Download the package **DistributedNotification.pkg** from releases.
2. Install the package.
3. Open Terminal and launch the Helper with : ```sudo "/Library/Application Support/DistributedNotification/DistNotifHelper"```
4. Verify that your log file has been reset by typing ```cat /var/log/DNHelper.log ```. It should be empty.
5. Open another Terminal and launch the Notifier with : ```/Library/Application\ Support/DistributedNotification/DistNotifNotifier```
6. The first Terminal should display the same output than the previous test.
7. You can also verify the log file with ```cat /var/log/DNHelper.log ```
8. Stop the helper from the first terminal with ```Ctrl-C```

### From Launch Daemon

1. Open a Terminal and type ```sudo launchctl load /Library/LaunchDaemons/com.mknecht.distnotif.daemon.plist```
2. You can verify that the Helper application is running with Activity Monitor by selecting View/All Processes
3. Verify that your log file has been reset by typing ```cat /var/log/DNHelper.log ```. It should be empty.
4. Open a Terminal and launch the Notifier with : ```/Library/Application\ Support/DistributedNotification/DistNotifNotifier ```
5. Display the log file with ```cat /var/log/DNHelper.log ```. It should only display ```
Helper: started ...``` and prove that there are different behaviours from distributed notifications. I would like to understand why...
