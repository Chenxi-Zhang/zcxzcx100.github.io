#! /bin/bash
demoFun(){
	echo "Shell function."
}
demoFun
printf "printf: Hello, Shell.\n"
printf "format-string: %s\n" hahaha
printf "format-string: %-10s\n" 12345 
echo `date`
echo -e "OK! \\\\n \n"
echo -e "OK! \\\\c \c"
read -p "Enter:" -n 6 -s name
echo "$name entered"
a=10
b=20
if [ $a -lt 100 -a $b -gt 15 ]
then
	echo "a < 100 and b > 15 : true"
else
	echo "a < 100 and b > 15 : false"
fi
val=`expr $a \* $b`
val=$(($a * $b))
echo $val
if [ $a == $b ]
then
	echo "a==b"
fi
if [ $a != $b ]
then
	echo "a!=b"
fi
echo "Hello World!"
echo "File name: $0"
echo "First arg: $1"
echo "Second arg: $2"
echo "Third arg: $3"
echo "No. args: $#"
echo "All args: $*"
echo "Script process Id: $$"
echo "All args as @\$ style: " $@
echo "Set: $-"
echo "Exit stat: $?"
val=`expr 2 + 2`
echo "Sum: $val"
