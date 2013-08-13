#!/usr/bin/perl --

$incs_folder_PATH='incs'; #relative or absolute path to incs folder
$txts_folder_PATH='txts'; #relative or absolute path to txts folder
$imgs_folder_URL='/editor/imgs'; #virtual or full URL to imgs folder
$flash_folder_URL='/editor/flash'; #virtual or full URL to flash folder

# On Windows servers the above $incs_folder_PATH & $txts_folder_PATH be set above and must 
#    be ABSOULTE paths if they are NOT installed in the same path as edit.cgi
# On Windows servers the $incs_folder_PATH & $txts_folder_PATH can instead be 
#    set by the following if they ARE installed in the same path as edit.cgi

if($^O eq 'MSWin32'){
	$0 = $^X unless ($^X =~ m%(^|[/\\])(perl)|(perl.exe)$%i);
	my ($program_dir) = $0 =~ m%^(.*)[/\\]%;
	$program_dir ||= ".";
	$program_dir =~ s`/[^/]+$``;$program_dir =~ s`\\`/`g;$program_dir =~ s`^\w:``g;
	$root = $program_dir;
	$root=~s`/[^/]+$``;
	$test=$program_dir."/".$incs_folder_PATH;
	if(-d $test){
		$incs_folder_PATH="$program_dir/incs"; 
		$txts_folder_PATH="$program_dir/txts";
	}
}
########################################################
#BEGIN{$ENV{'DOCUMENT_ROOT'}='../'}

#$fake_temp="$ENV{'DOCUMENT_ROOT'}/some_folder";

if($ENV{'SCRIPT_URI'} =~ /https/ || $ENV{'SERVER_PORT'} =~ /443/){$http="https://"}else{$http="http://"}
push(@INC,$incs_folder_PATH);
require 'routines.htm';

$background_color="#D9D9D6";
$host=$http.$ENV{'HTTP_HOST'};
$host_=$ENV{'HTTP_HOST'};
$pi=$ENV{'PATH_INFO'} || $ENV{'SCRIPT_NAME'};
$pt=$ENV{'PATH_TRANSLATED'} || $ENV{'SCRIPT_FILENAME'};
$pt=~s`(.+)$pi`$1`;
if(-d $pt){$root=$pt}
if($ENV{'DOCUMENT_ROOT'}){$root=$ENV{'DOCUMENT_ROOT'}}
if($ENV{'SUBDOMAIN_DOCUMENT_ROOT'} && $ENV{'SUBDOMAIN_DOCUMENT_ROOT'}=~ m`^$ENV{'DOCUMENT_ROOT'}`){$root=$ENV{'SUBDOMAIN_DOCUMENT_ROOT'}}

if(!$root){&noRoot}
$uttf=$host.$ENV{'SCRIPT_NAME'};
$utif=$imgs_folder_URL;
$close_img="modal_close";
&browser;
&config;

$qs=$ENV{'QUERY_STRING'};
if($qs=~/^flashRegex=/){&flashRegex}
$qs=~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

($action,$params)=split(/=/,$qs,2);
if($qs eq ''){$action="getToolbar"}
&$action;

