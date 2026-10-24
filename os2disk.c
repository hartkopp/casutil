/*
 *   md100.c - Handle Casio md100 disk images
 *
 *   os2disk.c - Direct access module for OS/2 and eCS
 *
 *   Marcus von Cube
 *
 *   30.03.2006 0.1 created - Sorry, doesn't work yet :-(
 */
#define USE_IOCTRL 0

#define         INCL_BASE
#define         INCL_DOSDEVIOCTL  /* may or may not be part of INCL_BASE!    */
#define         INCL_DOSFILEMGR   /* may or may not be part of INCL_BASE!    */

#include        <os2.h>

/*
 *  MD-100 disks are 320KB, 80 tracks, SS, DD, 16 sectors per track,
 *  256 bytes per sector. This parameterblock is first read from the driver
 *  and then modified and rewritten.
 */
#pragma pack(1)
BIOSPARAMETERBLOCK DriveParams, SavedParams, TestParams;

#if USE_IOCTL
/*
 *  This stucture defines the data for a complete track (16 sectors).
 *  It is modeled after TRACKLAYOUT
 */
#pragma pack(1)
struct _trackLayout {
    BYTE   bCommand;
    USHORT usHead;
    USHORT usCylinder;
    USHORT usFirstSector;
    USHORT cSectors;
    struct {
           USHORT usSectorNumber;
           USHORT usSectorSize;
    } TrackTable[ 16 ];
} TrackLayout =
{
    1,                     /* Sectors start with 1 and are consecutive */
    0,                     /* Only one side */
    0,                     /* Track to be set from 0 to 79 */
    0,                     /* First index in the TrackTable */
    16,                    /* # of sectors to read or write */
    {
        {  1, 256 },       /* Sectors and sizes */
        {  2, 256 },
        {  3, 256 },
        {  4, 256 },
        {  5, 256 },
        {  6, 256 },
        {  7, 256 },
        {  8, 256 },
        {  9, 256 },
        { 10, 256 },
        { 11, 256 },
        { 12, 256 },
        { 13, 256 },
        { 14, 256 },
        { 15, 256 },
        { 16, 256 }
    }
};

#define SIZE_TRACKLAYOUT sizeof( TrackLayout )

/*
 *  Here goes the data
 */
char TrackBuffer[ 16 * 256 ];
#define SIZE_TRACK sizeof( TrackBuffer )

/*
 *  Flags if there is valid and/or uncommitted data
 */
int WritePending = FALSE;
int TrackValid   = FALSE;

#endif /* USE_IOCTL */

/*
 *  Handle and Name
 */
HFILE DriveHandle;
char DriveName[ 3 ];

/*
 *  Routines
 */
int openDirect( char *name, int create, int noUpdate );
int closeDirect( void );
int readDirect( void *dest, int number, int count );
int writeDirect( void *source, int number, int count );
#if USE_IO_CTL
int readTrack( void );
int writeTrack( void );
#endif
int checkError( char *message, APIRET rc );


/*
 *  Get access to the device
 */
#ifdef __BORLANDC__
#pragma argsused
#endif
int openDirect( char *name, int create, int noUpdate )
{
    APIRET rc;
    ULONG ulAction;
    ULONG ulFlags = OPEN_FLAGS_DASD | OPEN_FLAGS_WRITE_THROUGH
                  | OPEN_FLAGS_RANDOM | OPEN_FLAGS_NO_CACHE;
    BYTE cmd[ 2 ] = { 0, 0 };
    ULONG ulSize = sizeof( BIOSPARAMETERBLOCK );

#if USE_IOCTL
    TrackValid = WritePending = FALSE;
#endif

    DriveName[ 0 ] = toupper( name[ 0 ] );
    DriveName[ 1 ] = ':';
    DriveName[ 2 ] = '\0';

    /*
     *  Get currrent BPB
     */
    cmd[ 0 ] = 0;
    cmd[ 1 ] = (BYTE) ( DriveName[ 0 ] - 1 & 0x1F );
    rc = DosDevIOCtl( -1, IOCTL_DISK, DSK_GETDEVICEPARAMS,
                      &cmd, 2, NULL,
                      &SavedParams, ulSize, &ulSize );
    if ( rc != 0 ) {
        return checkError( "Can't get device information", rc );
    }
#if DEBUG
    printf( "Device type = %d\n", SavedParams.bDeviceType );
    printf( "Media type = %02X\n", SavedParams.bMedia );
#endif

    /*
     *  Open drive
     */
    if ( noUpdate ) {
        ulFlags |= OPEN_ACCESS_READONLY | OPEN_SHARE_DENYNONE;
    }
    else {
        ulFlags |= OPEN_ACCESS_READWRITE | OPEN_SHARE_DENYREADWRITE;
    }

    rc = DosOpen( DriveName, &DriveHandle, &ulAction, 0L,
                  FILE_NORMAL, OPEN_ACTION_OPEN_IF_EXISTS, ulFlags, NULL );

    if ( rc != 0 ) {
        fprintf( stderr, "Error opening device \"%s\": Error %d\n",
                         DriveName, rc );
        return NOT_OK;
    }

    /*
     *  Lock drive
     */
    rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_LOCKDRIVE,
                      cmd, 1, NULL, NULL, 0, NULL );
    if ( rc != 0 ) {
        return checkError( "Error locking device", rc );
    }

    /*
     *  Create modified BPB
     */
    DriveParams = SavedParams;
    DriveParams.usBytesPerSector = 256;
    DriveParams.cSectors = 80 * 16;
    DriveParams.cHeads = 1;
    DriveParams.usSectorsPerTrack = 16;
    DriveParams.cCylinders = 80;
    DriveParams.bDeviceType = DEVTYPE_35;
    DriveParams.bMedia = 0xF9;

    /*
     *  Set new BPB for media
     */
    cmd[ 0 ] = 2;
    rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_SETDEVICEPARAMS,
                      &cmd, 1, NULL,
                      &DriveParams, ulSize, &ulSize );
    if ( rc != 0 ) {
        return checkError( "Can't set device information", rc );
    }

#if DEBUG
    printf( "opened\n" );
    /*
     *  Get currrent BPB for testing purposes
     */
    cmd[ 0 ] = 1;
    rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_GETDEVICEPARAMS,
                      &cmd, 1, NULL,
                      &TestParams, ulSize, &ulSize );
    if ( rc != 0 ) {
        return checkError( "Can't get device information", rc );
    }
    printf( "Device type = %d\n", TestParams.bDeviceType );
    printf( "Media type = %02X\n", TestParams.bMedia );
#endif

    return OK;
}


/*
 *  Terminate access
 */
int closeDirect( void )
{
    APIRET rc;
    BYTE cmd[ 2 ];
    ULONG ulSize = sizeof( BIOSPARAMETERBLOCK );

#ifdef USE_IOCTL
    if ( WritePending ) {
        /*
         *  Track not yet written
         */
        if ( OK != writeTrack() ) {
            return NOT_OK;
        }
    }
#endif

    if ( DriveHandle > 0 ) {
        /*
         *  Set old BPB
         */
        cmd[ 0 ] = 0;
        rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_SETDEVICEPARAMS,
                          &cmd, 2, NULL,
                          &SavedParams, ulSize, &ulSize );
        if ( rc != 0 ) {
            fprintf( stderr, "Can't reset device information: Error %d", rc );
        }

        /*
         *  Close Handle
         */
        rc = DosClose( DriveHandle );
        DriveHandle = 0;
        if ( rc != 0 ) {
            return checkError( "Error closing device", rc );
        }
    }
    return OK;
}


#if USE_IOCTL
/*
 *  Read data
 */
int readDirect( void *dest, int number, int count )
{
    char *buff = (char *) dest;
    USHORT track = (USHORT) ( number / 4 );
    int tracks = ( count + 3 ) / 4;
    int offset;
    size_t length;

    if ( WritePending ) {
        /*
         *  Write pending data
         */
        if ( OK != writeTrack() ) {
            return NOT_OK;
        }
    }

    while ( tracks-- > 0 ) {
        /*
         *  Read a complete Track
         */
        if ( !TrackValid || TrackLayout.usCylinder != track ) {
            /*
             *  Setup TrackLayout for next read
             */
            TrackLayout.usCylinder = track;
            TrackLayout.usFirstSector = 0;
            TrackLayout.cSectors = 16;

            if ( OK != readTrack() ) {
                return NOT_OK;
            }
        }

        /*
         *  Now copy buffers
         */
        offset = 256 * ( number % 4 );
        length = (size_t) ( SIZE_TRACK - offset );
        memcpy( dest, TrackBuffer + offset, length );

        ++track;
        buff += length;
        number = 4 * track;
    }

    return OK;
}


/*
 *  Write data
 */
int writeDirect( void *source, int number, int count )
{
    return checkError( "Write error", 1 );
}


/*
 *  Read current track from disk
 */
int readTrack( void )
{
    APIRET rc;
    ULONG ulCount;
    ULONG ulOffset;
    ULONG ulSize = SIZE_TRACKLAYOUT;

    ulOffset = TrackLayout.usFirstSector * 256L;
    ulCount = TrackLayout.cSectors * 256L;

#if DEBUG
    printf( "Read track %d, sectors %d-%d\n",
            TrackLayout.usCylinder, TrackLayout.usFirstSector + 1,
            TrackLayout.usFirstSector + TrackLayout.cSectors );
#endif
    rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_READTRACK,
                      &TrackLayout, ulSize, &ulSize,
                      TrackBuffer + ulOffset, ulCount, &ulCount );
    TrackValid = ( rc == 0 );
    return checkError( "Can't read track", rc );
}


/*
 *  Write current track to disk
 */
int writeTrack( void )
{
    APIRET rc;
    ULONG ulCount;
    ULONG ulOffset;
    ULONG ulSize = SIZE_TRACKLAYOUT;

    ulOffset = TrackLayout.usFirstSector * 256L;
    ulCount = TrackLayout.cSectors * 256L;

#if DEBUG
    printf( "Write track %d, sectors %d-%d\n",
            TrackLayout.usCylinder, TrackLayout.usFirstSector + 1,
            TrackLayout.usFirstSector + TrackLayout.cSectors );
#endif

    rc = DosDevIOCtl( DriveHandle, IOCTL_DISK, DSK_WRITETRACK,
                      &TrackLayout, ulSize, &ulSize,
                      TrackBuffer + ulOffset, ulCount, &ulCount );
    WritePending = FALSE;
    TrackValid = ( ulOffset == 0L && ulCount == 16 * 256L );

    return checkError( "Can't write track", rc );
}


#else /* not USE_IOCTL */

/*
 *  Read data
 */
int readDirect( void *dest, int number, int count )
{
    APIRET rc;
    ULONG ul = number * 1024L;
    
    rc = DosSetFilePtr( DriveHandle, ul, FILE_BEGIN, &ul );
    if ( rc != 0 ) {
        return checkError( "Can't position disk", rc );
    }

    ul = count * 1024L;
    rc = DosRead( DriveHandle, dest, ul, &ul );
    return checkError( "Read error", rc );
}


/*
 *  Write data
 */
int writeDirect( void *source, int number, int count )
{
    APIRET rc;
    ULONG ul = number * 1024L;
    
    rc = DosSetFilePtr( DriveHandle, ul, FILE_BEGIN, &ul );
    if ( rc != 0 ) {
        return checkError( "Can't position disk", rc );
    }

    ul = count * 1024L;
    rc = DosWrite( DriveHandle, source, ul, &ul );
    return checkError( "Write error", rc );
}

#endif /* not USE_IOCTL */


/*
 *  Check for errors
 */
int checkError( char *message, APIRET rc )
{
    if ( rc != 0 ) {
        fprintf( stderr, "%s: Error %d\n", message, rc );
        closeDirect();
        return NOT_OK;
    }
    else {
        return OK;
    }
}

