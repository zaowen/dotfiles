#!/bin/zsh

export VERBOSE

function deploy() {
# check if File DNE
LOCALVER=$2
REPOVER=$1
if [[ ! -f $LOCALVER ]]; then
   if [[ ! -v VERBOSE ]]; then
      echo "$LOCALVER does not exist, hard-linking...\n"
   fi
   # Make Hard Link
   ln $REPOVER $LOCALVER
else 
   # if file exists

   #Get the inodes for comparision
   INODE1=$(ls -li $REPOVER | cut -d " " -f1)
   INODE2=$(ls -li $LOCALVER | cut -d " " -f1)

   if [[ $INODE1 == $INODE2 ]]; then
      # Check if files are already hard-linked
      if [[ ! -v VERBOSE ]]; then
         echo "$REPOVER and $LOCALVER are already hard-linked\n"
      fi
      return
   elif (diff $LOCALVER $REPOVER 1>/dev/null); then
      #Check if the files are identical
      if [[ ! -v VERBOSE ]]; then
         echo "$REPOVER and $LOCALVER are identical but not hard-linked, hard-linking\n"
      fi

      rm $LOCALVER
      ln $REPOVER $LOCALVER
   else
      # If both files exist but are diffrent
      while [[ ! -v ANS ]]; do
         echo Found $LOCALVER but file is diffrent than $REPOVER.
         echo "Accept which?";
         echo "\t1: Keep $REPOVER (remote)"
         echo "\t2: Keep $LOCALVER (local)"
         echo "\t3: Display diff $REPOVER $LOCALVER"
         echo "\t4: Ignore and continue"
         echo "\tq: Quit"
         read -k1 ANS
         printf "\b"

         case $ANS in
            1)
               mv $LOCALVER $LOCALVER.bak
               ln $REPOVER $LOCALVER
            ;;

            2)
		mv $LOCALVER $REPOVER
               ln $REPOVER $LOCALVER
            ;;

            3)
               diff $REPOVER $LOCALVER | less
               echo "\n"
               unset ANS
               clear
            ;;

            4)
               clear
            ;;

	    q)
		exit 1
		;;

            *)
               echo "I didn't understand your answer..."
               unset ANS
               clear
            ;;

         esac
      done

      unset ANS
   fi
fi
}

while getopts ":v" opt; do
  case $opt in
    v)
      unset VERBOSE;
      ;;
  esac
done

echo Deploying dotfiles...
for i in $(find . ! -path '*.git*' ! -name 'README.md' ! -name 'deploy.sh*' ! -name 'install' -printf "%P\n" ); do
   if [[ -d $i ]]; then
      if [[ -f $HOME/$i ]]; then
         mkdir $HOME/$i
      fi
   else
      deploy $i $HOME/$i
   fi
done

