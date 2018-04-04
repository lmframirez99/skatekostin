#!/usr/bin/perl -w
#print "Content-type: text/plain\n\n";
#print "testing...\n";

use strict;
use warnings;
#use lib '/home/ec2-user/perl5/lib/perl5';
#use lib '/usr/local/share/perl5/';
#use 5.008;

use Data::Dumper;
use CGI qw(:standard);
#use Email::Sender::Simple qw(sendmail);
#use Email::Simple;
#use Email::Simple::Creator;
use Mail::Sendmail;

my $q = CGI->new();

my %form_information;

$form_information{contact_name} = $q->param('contact_name');
$form_information{contact_email} = $q->param('contact_email');
$form_information{phone_number} = $q->param('phone_number');
$form_information{skater_level} = $q->param('skater_level');
$form_information{message} = $q->param('message');

#if ($form_information{contact_name} !~ /^[\s\w.-]+$/) {
#    print "Name must contain only alphanumeric characters.";
#    exit;
#}


my $message = "Information Request from Website\n\n" .
    "Contact Name: $form_information{contact_name}\n\n" .
    "Contact Email: $form_information{contact_email}\n\n" .
    "Contact Phone: $form_information{phone_number}\n\n" . 
    "Skater Level: $form_information{skater_level}\n\n" . 
    "Message: \n$form_information{message}\n\n";


warn("We're processing the mail");
# Send a copy to me
my $test = 1; 

  my %mail = ( To      => 'lmframirez@gmail.com',
	       From    => 'SkateKostin International <skatekostininternational@gmail.com>',
	       Message => $message,
	       Subject => "Information request from site"
           );

  #sendmail(%mail) or die $Mail::Sendmail::error;
sendmail(%mail) or $test = undef;

# Send form to Genevieve
my $test = 1; 

  my %mail = ( To      => 'ge.coulombe@yahoo.ca',
	       From    => 'SkateKostin International <skatekostininternational@gmail.com>',
	       Message => $message,
	       Subject => "Information request from site"
           );

  #sendmail(%mail) or die $Mail::Sendmail::error;
sendmail(%mail) or $test = undef;


my $URL = "http://ec2-13-58-254-34.us-east-2.compute.amazonaws.com/contact/thankyou.html";

unless ($test) {
    my $contact_url = $URL . "?error=email_not_sent";
    print $q->redirect($contact_url);
}

print $q->redirect($URL);

#print "Thank you for your information request\n\n" . $message;

