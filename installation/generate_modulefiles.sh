#!/bin/bash
# Usage  : Use for generate modulefiles.
# Author : Chiatse J. Wang (b03201004@ntu.edu.tw)
# History: April 18, 2018 First release

# Get home path
if [ -z $1 ]; then
    echo "Invalid home directory $1"; exit -1;
fi

LIBRARYHOME=${HOME}/local/modules/Cellar/
MODULEHOME=${HOME}/local/modules/modulefiles/

# Get module name
read -p "What is your module name? [Default: python] " modulename
modulename=${modulename:-"python3"}

read -p "What is your module version? [Default: 3.6] " moduleversion
# moduleversion=${moduleversion:-'[file tail $ModulesCurrentModulefile]'}
moduleversion=${moduleversion:-'3.6'}

# read -p "What is your module prefix? [Default: $LIBRARYHOME$modulename/$moduleversion]" moduleprefix
# moduleprefix=${moduleprefix:-"$LIBRARYHOME$modulename/$moduleversion"}

if [ ! -d $MODULEHOME$modulename ]; then
    #echo "$MODULEHOME$modulename doesn't exist!"; exit -1;
    echo "$MODULEHOME$modulename doesn't exist!";
    mkdir $MODULEHOME$modulename
fi

cd $MODULEHOME$modulename

if [ ! -f $MODULEHOME$modulename/.source ]; then
    touch .source

    echo -e '# Author: Chiatse J. Wang <b03201004@ntu.edu.tw>\n' >> .source
    echo "set  name     $modulename" >> .source
    echo "set  version  [file tail \$ModulesCurrentModulefile]" >> .source
    echo -e "set  prefix   $LIBRARYHOME\${name}/\${version}\n" >> .source
    echo -e "module-whatis  \"Python \${version} Library\"\n" >> .source
    echo -e "conflict  \${name}\n" >> .source
    echo "prepend-path  PATH             \${prefix}/bin" >> .source
    echo "prepend-path  LD_LIBRARY_PATH  \${prefix}/lib" >> .source
    echo "prepend-path  PKG_CONFIG_PATH  \${prefix}/lib/pkgconfig" >> .source
fi

if [ ! -f $MODULEHOME$modulename/.version ]; then
    touch .version

    echo "#%Module" >> .version
    echo -e "# Author: Chiatse J. Wang <b03201004@ntu.edu.tw>\n" >> .version
    echo "set  ModulesVersion  \"${moduleversion}\"" >> .version
fi

touch ${moduleversion}
echo "#%Module1.0" >> ${moduleversion}
echo -e "# Author: Chiatse J. Wang <b03201004@ntu.edu.tw>\n" >> ${moduleversion}
echo "source  [file dirname \$ModulesCurrentModulefile]/.source" >> ${moduleversion}

