#!/usr/bin/perl
# Wallpaper manager (in perl)
# Chooses random backgrounds on startup.
# Sending this script SIGUSR1 will change wallpaper.
# Has a home and not home setting for more...fun papers ;^)

use strict;
use warnings;

# Capture Signal SIGUSR1
$SIG{USR1} = \&handleSig;

# Globals
my $HOMEWIFI = ""; # "CenturyLink0014";
my $DIR = ".w";
my $TIMEOUT = 5;
my $LOC = 1;
my $PAPER = "";

sub getwall {
#print "getwall\n";
  my @PAPES = glob( "~/Pictures/.w/*" );
  $PAPER = $PAPES[int(rand(scalar(@PAPES)))];
}

sub handleSig {
  getwall();
#print "SIGNAL\n";
}

sub checkwifi {
  my $SSID = `ifconfig` =~ /nwid (.*) chan/;

  if ( $SSID = $HOMEWIFI ){
    $DIR = ".nsw";
    $TIMEOUT = 5;
    $LOC = 1;
  } else {
    $DIR= ".w" ;
    $TIMEOUT = 60;
    $LOC = 2;
  }
}


sub setwall {
#print "setwall\n";
  my $OLDLOC = $LOC;
  system( "feh", "$PAPER", "--bg-fill" );

  checkwifi();
  if ( $OLDLOC != $LOC ) {
    getwall();
  }
}

# killall -q wallpaper.sh
for my $i ( `pgrep wallpaper.pl` ) {
  if ( $i != $$ ) {
    system( "kill -9 $i" );
  }
}

checkwifi();
getwall();

while ( 1 ) {
  setwall();
  sleep( $TIMEOUT );
}

