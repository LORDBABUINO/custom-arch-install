#!/bin/bash

contains_element() {
  for e in "${@:2}"; do [[ $e == $1 ]] && break; done;
}

script_list=("aui" "other" );
PS3="$prompt1"
echo -e "Select pos-intaller script:"
select OPT in "${script_list[@]}"; do
  if contains_element "$OPT" "${script_list[@]}"; then
    case $OPT in
      other)
        read -p "Write the pos-installer repository URL: " url
        read -p "Write the repository name" repository_name
        read -p "Write the script name" script_name
        git clone url
        cd ${repository_name}
        sh ./${script_name}
	cd ..
	rm -rf ${repository_name}
        ;;
      aui)
        git clone https://github.com/LORDBABUINO/${OPT}.git
        cd ${OPT}
        sh ./fifo
	cd ..
	rm -rf ${OPT}
        ;;
    esac
    break
  else
    echo "Invalid option. Try another one."
  fi
done
