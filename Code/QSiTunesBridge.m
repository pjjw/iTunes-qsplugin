//
//  QSiTunesBridge.m
//  iTunesPlugIn
//
//  Created by Nicholas Jitkoff on 1/22/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "QSiTunesBridge.h"

NSAppleScript *gQSiTunesScript = nil;

NSAppleScript *QSiTunesScript() {
	if (!gQSiTunesScript) {
			gQSiTunesScript = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:
				[[NSBundle bundleForClass:NSClassFromString(@"QSiTunesObjectSource")]  pathForResource:@"iTunes" ofType:@"scpt"]] error:nil];

	}
			return gQSiTunesScript;
}

iTunesApplication *QSiTunes()
{
	return [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
}

iTunesSource *QSiTunesLibrary()
{
	NSArray *librarySource = [[[QSiTunes() sources] get] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"kind == %i", iTunesESrcLibrary]];
	if ([[librarySource lastObject] exists]) {
		return [librarySource lastObject];
	}
	return nil;
}

iTunesPlaylist *QSiTunesDJ()
{
	NSArray *iTunesDJplaylists = [[[QSiTunesLibrary() playlists] get] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"specialKind == %i", iTunesESpKPartyShuffle]];
	if ([[iTunesDJplaylists lastObject] exists]) {
		return [iTunesDJplaylists lastObject];
	}
	return nil;
}
