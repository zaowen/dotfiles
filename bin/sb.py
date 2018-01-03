#!/usr/bin/python3 

import sys
from subprocess import call
import os

def yesno( prompt ):
	while(1):
		answ = input( prompt )
		if( answ == 'y' or answ == 'Y' ):
			return 'y'
		if( answ == 'n' or answ == 'N' ):
			return 'n'

def main():
	if( len(sys.argv)  < 3 ):
		print( "Invalid usage\n./sb.sh <Soundboard Key#> <Soundfile.wav>\n")
		sys.exit(-1)
	inputfile = sys.argv[2]
	outputfile = "~/.config/i3/soundboard/F"
	keyexist = "no"	
	replace = "n"

	try:
		sbkey = int(sys.argv[1])
	except ValueError:
		print( "Invalid Sondboard Key#" )
		sys.exit(-1)	
	if ( sbkey > 11 or sbkey < 1 ):
		print( "Invalid Sondboard Key#" )
		sys.exit(-1)	



	outputfile = outputfile + str(sbkey) + ".wav"
	outputfile = os.path.expanduser( outputfile )

	if( inputfile == "remove"):
		call([ "rm" , outputfile ])
		sys.exit(0)		

	if( not os.path.exists ( inputfile ) ):
		print( "Could not find Soundfile.wav" )		

	if(  os.path.exists( outputfile ) ):
		replace = yesno ("Soundboard key already in use.\nReplace?[y/n]: " )
		if( replace == 'n'):
			print("Exiting")
			sys.exit(0)	

	if( inputfile[-4:] != ".wav" ):
		print( "Need to make wav")
		if( replace == 'y'):
			call([ "rm" , outputfile ] )

		call(["ffmpeg" , "-i" , inputfile , outputfile ] )

	else:
		call(["cp", inputfile, outputfile])

		

if __name__ == "__main__":
	main()
