#!/bin/zsh

export VERBOSE

function deploy() {
# check if File DNE
if [[ ! -f $2 ]]; then
   if [[ ! -v VERBOSE ]]; then
      echo "$2 does not exist, hard-linking...\n"
   fi
   # Make Hard Link
   ln $1 $2
else 
   # if file exists

   #Get the inodes for comparision
   INODE1=$(ls -li $1 | cut -d " " -f1)
   INODE2=$(ls -li $2 | cut -d " " -f1)

   if [[ $INODE1 == $INODE2 ]]; then
      # Check if files are already hard-linked
      if [[ ! -v VERBOSE ]]; then
         echo "$1 and $2 are already hard-linked\n"
      fi
      return
   elif (diff $2 $1 1>/dev/null); then
      #Check if the files are identical
      if [[ ! -v VERBOSE ]]; then
         echo "$1 and $2 are identical but not hard-linked, hard-linking\n"
      fi

      rm $2
      ln $1 $2
   else
      # If both files exist but are diffrent
      while [[ ! -v ANS ]]; do
         echo Found $2 but file is diffrent than $1.
         echo "Accept which?";
         echo "\t1: Keep $1"
         echo "\t2: Keep $2"
         echo "\t3: Display diff $1 $2"
         echo "\t4: Ignore and continue"
         read -k1 ANS
         printf "\b"

         case $ANS in
            1)
               mv $2 $2.bak
               ln $1 $2
            ;;

            2)
               ln $2 $1
            ;;

            3)
               diff $1 $2 | less
               echo "\n"
               unset ANS
               clear
            ;;

            4)
               clear
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
for i in $(find . ! -path '*.git*' ! -name 'README.md' ! -name 'deploy.sh' -printf "%P\n" ); do
   if [[ -d $i ]]; then
      if [[ -f $HOME/$i ]]; then
         mkdir $HOME/$i
      fi
   else
      deploy $i $HOME/$i
   fi
done

