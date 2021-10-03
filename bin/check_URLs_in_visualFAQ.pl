#!/usr/bin/perl

## Syntax:
# $ ~/src/visualFAQ-fr/bin/check_URLs_in_visualFAQ.pl --base_url 'https://faq.gutenberg.eu.org/' visualFAQ-fr.tex

use strict ;
use warnings ;

use constant TRUE  => 1 ;
use constant FALSE => 0 ;

#use List::Util qw{min max sum} ;
use Getopt::Long ;
use LWP::UserAgent ;
use HTTP::Request::Common qw{ POST } ;


my $base_url_opt = 'https://faq.gutenberg.eu.org/' ;
GetOptions( 'base_url=s'       => \$base_url_opt,
          ) or die "Cannot parse options" ;


######################################################################
## Parameters


######################################################################
## Prototypes

sub check_url ($) ;


######################################################################
## Real work

our $ua = LWP::UserAgent->new() ;
my $error_count = 0 ;


while( <> )
  {chomp ;
   if ( /\\faq\{([^\}]+)\}/ )
     {my $page_full_name = $1 ;

      if ( not check_url( $base_url_opt.$page_full_name ) )
        {#FIXME
	}
     }
  }



exit 0 ;

######################################################################
######################################################################
######################################################################
## Subs

sub check_url ($)
{my $url = shift ;

 my $req = HTTP::Request->new( GET => $url ) ;
 my $res = $ua->request( $req ) ;

 #FIXME


 return ;
}



__END__
