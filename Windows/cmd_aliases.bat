@echo off

:: How to use
:: Run cmd /k cmd_aliases.bat
:: Recommend adding a shortcut to Command Prompt with this as the target.

:: Print text without a newline
echo | set /p ENHANCED_PROMPT=Loading enhanced configuration...

:: Path Modification

:: set PATH=%PATH%;

:: General Aliases

doskey ln=assign $*
doskey file=assoc $*
doskey batch=at $*
doskey cron=at $*
doskey chown=attrib $*
doskey chmod=attrib $*
doskey cd=cd /D $*
doskey pwd=cd $*
doskey fsck=chkdsk $*
doskey clear=cls $*
doskey cp=copy $*
doskey rm=del $*
doskey ls=dir /D $*
doskey history=doskey /h $*
doskey grep=find $*
doskey man=help $*
doskey ifconfig=ipconfig $*
doskey top=mem $*
doskey less=more $*
doskey mv=move $*
doskey w=net session $*
doskey who=net session $*
doskey uptime=net statistics $*
doskey lpr=print $*
doskey env=set $*
doskey ps=tasklist $*
doskey traceroute=tracert $*
doskey cat=type $*
doskey alias=doskey $*

:: Vim Aliases
doskey vi=vim $*
doskey view=vim -R $*


:: ls Aliases

doskey ll=dir /Q $*
doskey la=dir /Q $*

:: Windows Aliases




:: Finalize

echo done.

set ENHANCED_PROMPT=1

echo The current time is %Date%, %Time%
