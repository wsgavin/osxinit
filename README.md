# OS X Initialization

These are a set of scripts I've created to setup my OS X box. I've learned quite a bit from other folks dotfiles and install scripts and do my best to provide acknowledgments.

The one major difference I feel I've done is to setup install scripts per program/tool to modularize the install process. Also, I did not copy verbatum. Not particularly interested in copying someone exactly, just to be inspired by them.

## Requirements

To run these scripts the OS X box will need to need to meet a few requirements.

- Internet connection
- Xcode command line tools i.e. `git`

I've created a script to test for these requirements. And yes, if you can run this you should already have an Internet connection.

    $ curl -s https://raw.githubusercontent.com/wsgavin/osxinit/master/check.sh | sh

If an OS X fresh install you will probably have to do the following.

    $ xcode-select --install

![ALT xcode-select Install Screen][./images/xcode-select.install.png]

TODO: Grab screen shots.
TODO: Install vs. Xcode and go ahead and download java.

I did this because I was not initially aware of the process and thought documenting how to get there was worth it. For me it's trivial now, but for the uninitiated probably worth the understanding.

Once complete the `check.sh` script should tell you it's all good to go.

TODO: Have it spit out the commands below.

## OS X Initialization Files

Let's checkout the git repository, cd into osxinit and run `initialize.sh`.

    $ git clone https://github.com/wsgavin/osxinit.git
    $ cd osxinit
    $ ./initialize.sh

## Java

For Minecraft, the latest Java update from Apple is required. You can find the download at the following URL.

https://support.apple.com/kb/DL1572?locale=en_US

Follow the instructions provided on the site.

## TODO

### OS X settings

- Screen Saver
