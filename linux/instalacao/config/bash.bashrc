# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.

	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi


## ---- Configuracoes para o Java

export JAVA_DIR=/opt/java

# export JAVA_HOME=/opt/java/jdk-producao
# export JAVA_HOME=/usr/lib/jvm/java-6-sun
# export JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_24
# export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_17
export JAVA_HOME=$JAVA_DIR/jdk
export JRE_HOME=$JAVA_DIR/jdk/jre

export ANT_HOME=$JAVA_DIR/apache-ant
export CATALINA_HOME=$JAVA_DIR/apache-tomcat
export MAVEN_HOME=$JAVA_DIR/apache-maven
export M2_HOME=$JAVA_DIR/apache-maven
export ANDROID_SDK=$JAVA_DIR/android-sdk-linux
export ANDROID_NDK=$JAVA_DIR/android-ndk-linux

export OC4J_HOME=$JAVA_DIR/oc4j
export J2EE_HOME=$OC4J_HOME/j2ee/home

# export GWT_HOME=$JAVA_DIR/gwt-2.5.1
export GWT_HOME=$JAVA_DIR/gwt

export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:/usr/share/java/mysql.jar
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin:$ANT_HOME/bin:$MAVEN_HOME/bin:$CATALINA_HOME/bin:$GWT_HOME:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools

## ---- Configuracoes para o Python

export PYTHON_DIR=/opt/python

export PYTHONPATH=$PYTHONPATH:$PYTHON_DIR/pyjamas
export PATH=$PATH:$PYTHON_DIR/pyjamas/bin

## ---- Configuracoes para o Oracle

export ORACLE_HOME=/opt/oracle/instantclient_11_2
export TNS_ADMIN=/opt/oracle/instantclient_11_2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME
# export NLS_LANG='BRAZILIAN PORTUGUESE_BRAZIL.WE8ISO8859P1'
export NLS_LANG='BRAZILIAN PORTUGUESE_BRAZIL.UTF8'
export PATH=$PATH:$ORACLE_HOME

