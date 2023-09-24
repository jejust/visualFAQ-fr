#!/usr/bin/perl

## Syntax:
# $ ~/src/visualFAQ-fr/bin/check_URLs_in_visualFAQ.pl --base_dir '/opt/dokufaq/dokuwiki/data/pages/' visualFAQ-fr.tex

use strict ;
use warnings ;

use constant TRUE  => 1 ;
use constant FALSE => 0 ;

#use List::Util qw{min max sum} ;
use Getopt::Long ;


my $base_dir_opt = '/var/lib/dokufaq/data/pages/' ;
GetOptions( 'base_dir=s'      => \$base_dir_opt,
          ) or die "Cannot parse options" ;


######################################################################
## Parameters

my %already_checked ;
$already_checked{'#1'} = TRUE ;

######################################################################
## Prototypes

sub check_page ($) ;


######################################################################
## Real work

while( <> )
  {chomp ;
   if ( /\\faq\{([^\}]+)\}/ )
     {my $page_full_name = $1 ;

      if (    not exists $already_checked{$page_full_name}
          and not check_page( $page_full_name )
         )
        {print $., "\t", $page_full_name, "\n" ;
        }
      $already_checked{$page_full_name}++ ;
     }
   elsif ( /%.*FAQfr:\.+\(\s*(\S+)\s*\)" / )
     {# Same thing the previously, but I want errors in the \faq{} form
      # to be reported in priority
      my $page_full_name = $1 ;

      if (    not exists $already_checked{$page_full_name}
          and not check_page( $page_full_name )
         )
        {print $., "\t", $page_full_name, "\n" ;
        }
      $already_checked{$page_full_name}++ ;
     }
  }



exit 0 ;

######################################################################
######################################################################
## Subs

sub check_page ($)
{my $page_name = shift ;

 if (    -e $base_dir_opt.'/'.$page_name.'.txt'
     and -s $base_dir_opt.'/'.$page_name.'.txt' >= 10
    )
   {return TRUE ;
   }
 else
   {return undef() ;
   }
}


__END__
