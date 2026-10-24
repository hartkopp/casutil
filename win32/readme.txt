The program md100 in this package makes use of LibDsk by John Eliott.

Please visit his site at http://www.seasip.demon.co.uk/Unix/LibDsk

For Windows NT and above, an auxiliary driver, written by Simon Owen,
is needed by LibDsk:

http://simonowen.com/fdrawcmd/

The install subdirectory of this folder contains the driver.
Install it by starting FdInstall.exe 

On Windows 9x/ME, you should start the program LDSERVER.EXE before you
access the disk. This server is a 16 bit program which can do some tricks 
with the floppy controller that a 32 bit program can't. The program and
its dll can be found in the win95 subdirectory of this folder.

Marcus von Cube
