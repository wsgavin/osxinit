# OS X Setup (osxinit)

**N.B.** The contents of this repository has been tested on Mac OS X 10.11.x El Capitan.

**N.B.** NO WARRANTY USE AT YOUR OWN RISK

**N.B.** This repository is still a work in progress.

These are a set of scripts I've created to setup my OS X box. I've learned quite a bit from other folks dotfiles and install scripts and do my best to provide acknowledgments. Essentially Mathias Bynens has been the major influence. His dotfile can be found here https://github.com/mathiasbynens/dotfiles.

There's an order to the scripts.

1. `check.sh`
2. `initialize.sh`
3. `setup.sh`
4. `osx.sh`

## `check.sh`

`check.sh` essentially validates that you have some prerequisites before you start. Specifically we are looking for `git` and an Internet connection. The script will instruct you through any installs if you do not meet the requirements already. Otherwise the script will let you know all is good.

I wrote this script because I was not initially aware of the process and thought documenting how to get there was worth it. For me it's trivial now, but for the uninitiated probably worth the understanding.

## `initialize.sh`

`initialize.sh` will start the base install of tools and applications. Essentially this is homebrew doing the major lifting. At this time there is only one tool I cannot install via homebrew, `gvm`.

## `setup.sh`

`setup.sh` is a combination of environmental setups (e.g. copying dotfiles in the home directory) as well as some additional installations. At some point I may be able to combine `initialize.sh` and `setup.sh` in one script but I've kept them separate for now.

## `osx.sh`

`osx.sh` sets up some OS X specifics (e.g. Terminal defaults, Dock adjustments) that I prefer.

## Let's get started...

**N.B.** When running scripts you will not have to start with any `sudu` commands. They are embedded in the script when needed.

To run these scripts the OS X box will need to need to meet a few requirements.

- Your account is an administrator
- Internet connection
- Xcode command line tools i.e. `git`

Run the following command below.

    $ curl -s https://raw.githubusercontent.com/wsgavin/osxinit/master/check.sh | sh

If it's reported that you do not have an Internet connection you likely have some issues. I say this because the script itself is downloaded via the Internet. Apologies, but I cannot help here.

If you find you are not in the `admin` group you will need to work with your system administrator. Otherwise you will not get far installing software.

If an OS X fresh install you will probably have to install some Xcode tools. The script will inform you what to run. For convenience I have put it below as well.

    $ xcode-select --install

The following are the expected windows that will pop up during the install.
Click 'Install':
![xcode-select Install Screen](./images/xcode-select.install.png)

Once you click install you will need to agree to the license agreement. After that the install will download and install `xcode-select` tools.

Once you feel you have corrected any issues run the script again. Once all the checks pass you will be greeted with a message saying "All good to go..." and will instruct you on the next steps.





TODO: Install vs. Xcode and go ahead and download java.



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

# RESTART

## TODO

- Combine initialize.sh and setup.sh.
- Get AppleID `com.apple.ids.service.com.apple.ess` LoginAs I think.

### Requirements

- Document the base install e.g. each step, inclusive of Apple ID, etc.

### USB Installer

```
sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
```

### OS X settings

- Screen Saver
- Document Solarized: https://github.com/tamul/solarized-osx-terminal-colors
- Document mysides: https://github.com/mosen/mysides

### Sublime Setup Notes

~/Library/Application Support/Sublime Text 3/Packages/User/

Package Control.sublime-settings
Preferences.sublime-settings
Default (OSX).sublime-keymap
Markdown.sublime-settings

### Parallels Notes

- 2 CPU 8 GB RAM 512MB Video
- No Sharing
- Configure to not save energy.
- Update
- Install Parallels Tools

### Manual Setup

- Dropbox
- CleanMyMac (serial)
- Google Chrome (login)
- Paralells (serial)

### SSH Keys

I wanted a solution to be able to store my SSH keys not on my local box as backup. One way to do this is to encrypt the files. The following commands below will encrypt a file with a password. Let's assumed the file name is id_rsa.

Encrypt:

```
openssl enc -in id_rsa -aes-256-cbc -pass stdin > id_rsa.enc
```

You won't specifically be prompted for a password but it is expected to be captured from STDIN. Once you enter you desired password press return.

Decrypt:

```
openssl enc -in id_rsa.enc -d -aes-256-cbc -pass stdin > id_rsa
```

# Assumptions

- Fresh install of OS X El Capitan is installed with one user. Assuming you follow the normal installation process this will be true.

# Issues

## Brew Download Failed

During a brew install, sometimes the download fails. For example you may see something like this:

```
==> Downloading https://downloads.arduino.cc/arduino-1.6.7-macosx.zip
######                                                                     8.5%
curl: (56) SSLRead() return error -9806
Error: Download failed on Cask 'arduino' with message: Download failed: https://downloads.arduino.cc/arduino-1.6.7-macosx.zip
```

I've not found a good way to "retry" the download or wait in this kind of situation. Still looking for a simple solution.



