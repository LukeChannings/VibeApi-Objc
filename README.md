#VibeApi-Objc

This document contains the Vibe api query methods for the Vibe Server. It depends on a modified version of socket.io-objc found here - https://github.com/TheFuzzball/socket.IO-objc.

This is a re-implementation of the client Api found in the Vibe Web Application here - https://github.com/TheFuzzball/Vibe/blob/master/modules/Api/Vibe.js.

##Usage:

Implement the VibeApiDelegate protocol in your AppDelegate and implement any of the following (all optional):

	- (void) vibeApiDidConnect;
	- (void) vibeApiDidDisconnect;
	- (void) vibeApiDidThrowError:(NSError *) error;
	
Connect to the VibeApi with:

	vibeApi = [[VibeApi alloc] initWithHostname:@"localhost" andPort:6232 andDelegate:self];

obviously changing the hostname and port as appropriate. Query the Api with any of the following (all re-implementations of the Javascript methods.):

	- (void) getArtistsWithCallback:(VibeCallback)callback;
	- (void) getArtistsInGenre:(NSString *) genre withCallback:(VibeCallback)callback;
	- (void) getAlbumsWithCallback:(VibeCallback)callback;
	- (void) getAlbumsByArtistWithId:(NSString *) identifier withCallback:(VibeCallback)callback;
	- (void) getTracksWithCallback:(VibeCallback)callback;
	- (void) getTracksInGenre:(NSString *) genre withCallback:(VibeCallback)callback;
	- (void) getTracksByArtist:(NSString *) artist withCallback:(VibeCallback)callback;
	- (void) getTracksInAlbum:(NSString *) identifier withCallback:(VibeCallback)callback;
	- (void) getTrackWithId: (NSString *) identifier withCallback:(VibeCallback)callback;
	- (void) getGenresWithCallback:(VibeCallback)callback;

The methods will execute a callback block when the data has finished, the Vibe Callback block returns an id (usually NSArray) that will contain the data. Example:

	[vibeApi getAlbumsByArtistWithId:@"7a3b691731db2969498907b960183633" withCallback:^(NSArray albums) {
	
		// do something with the albums.
	
	}]

The Api always returns an NSArray on the root level, with JSON objects being represented by NSDictionaries.