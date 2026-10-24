/*
 *   md100.c - Handle Casio md100 disk images
 *
 *   dosdisk.c - Direct access to floppy in DOS
 *
 *   contributed by Piotr Piatek
 */

#include <stdio.h>
#include <stdlib.h>	/* atexit */
#pragma inline


/* disk parameters */
#define Cylinders 80
#define Heads 1
#define Sectors 16
#define SecBase 1
#define SecSize 256

/* disk commands */
#define ReadSector 2
#define WriteSector 3

#define DSK_ERR_OK 0
#define MAX_ATTEMPTS 3

int drive;
int oldsecsize;
int oldeot;


/* change a disk parameter table entry */
int dpt (int offset, int data)
{
  _AX = offset;
  _BL = data;
  asm {
	push	ds
	mov	cx,0
	mov	ds,cx
	mov	bp, word ptr ds:0078h
	add	bp,ax
	mov	ds, word ptr ds:007Ah
	mov	al, byte ptr ds:[BP]
	mov	byte ptr ds:[BP],bl
	pop	ds
  }
  return (int) _AL;
}


/* restore the disk parameter table entries */
void exit_fn (void)
{
  (void) dpt (3, oldsecsize);
  (void) dpt (4, oldeot);
}


/* issue a disk command */
int DiskCmd (char *buf, int logsec, int cmd)
{
   int head, cylinder, sector;

   cylinder = logsec / Sectors;
   head = cylinder % Heads;
   cylinder /= Heads;
   sector = logsec % Sectors + SecBase;

  _DL = drive;
  _DH = head;
  _CH = cylinder;
  _CL = sector;
  _AH = cmd;
  _AL = 1;				/* sector count */
  asm {
	mov	bx, offset buf
	int	13h
  }
  return (int) _AH;
}


/*
 *  Check for errors
 */
int checkError( char *message, int err )
{
    if ( err != DSK_ERR_OK ) {
        fprintf( stderr, "%s: %d\n", message, err );
        return NOT_OK;
    }
    else {
        return OK;
    }
}


/*
 *  Get access to the device
 */
#ifdef __BORLANDC__
#pragma argsused
#endif
int openDirect( char *name, int create, int noUpdate )
{
    switch ( *name ) {
      case 'a':
      case 'A':
        drive = 0;
        break;
      case 'b':
      case 'B':
        drive = 1;
        break;
      default:
        return NOT_OK;
    }
    oldsecsize = dpt (3, 1);	/* change sector size to 256 */
    oldeot = dpt (4, SecBase+Sectors-1);
    atexit (exit_fn);
    return OK;
}


/*
 *  Terminate access
 */
int closeDirect( void )
{
    return OK;
}


/*
 *  Read data
 */
int readDirect( void *dest, int number, int count )
{
    int attempt;
    int err = DSK_ERR_OK;
    int sec  = 4 * number;
    int secs = 4 * count;
    char *buff = (char *) dest;

    while ( err == DSK_ERR_OK && secs-- > 0 ) {
        /*
         *  Read a single sector
         */
        for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++ ) {
            err = DiskCmd( buff, sec, ReadSector );
            if ( err == DSK_ERR_OK ) {
                break;
            }
        }
        ++sec;
        buff += SecSize;
    }

    return checkError( "Read error", err );
}


/*
 *  Write data
 */
int writeDirect( void *source, int number, int count )
{
    int attempt;
    int err = DSK_ERR_OK;
    int sec  = 4 * number;
    int secs = 4 * count;
    char *buff = (char *) source;

    while ( err == DSK_ERR_OK && secs-- > 0 ) {
        /*
         *  Write a single sector
         */
        for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++ ) {
            err = DiskCmd( buff, sec, WriteSector );
            if ( err == DSK_ERR_OK ) {
                break;
            }
        }
        ++sec;
        buff += SecSize;
    }

    return checkError( "Write error", err );
}
