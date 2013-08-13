#!/usr/bin/perl --

#use CGI::Carp qw(fatalsToBrowser);

#open(X,">test.txt") || &not;
#print X "HELLO";

print "Content-type: text/html\n\n";

print "VARS<P>";

print "<p>Environment:<br>\n";
foreach $e (sort keys %ENV) {
  print "<br><tt>$e => $ENV{$e}</tt>\n";
 }


sub not{
print "Content-type: text/html\n\n";
print qq~Your server could not open test.txt to write to it. Your server is not running suExec. EditWrx can not be installed on your server~;
exit;
}