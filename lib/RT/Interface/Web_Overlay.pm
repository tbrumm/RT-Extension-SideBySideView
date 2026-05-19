package HTML::Mason::Commands;

use strict;
use warnings;

# Wrap GetPageLayout so that a user's TicketViewLayout preference overrides
# the global PageLayoutMapping for RT::Ticket Display pages.
{
    no warnings 'redefine';
    my $orig = \&HTML::Mason::Commands::GetPageLayout;
    *HTML::Mason::Commands::GetPageLayout = sub {
        my %args = ( Object => '', Page => 'Display', @_ );

        if (   $args{Object}
            && ref( $args{Object} )
            && $args{Object}->isa('RT::Ticket')
            && ( $args{Page} // '' ) eq 'Display' )
        {
            my $cu = $HTML::Mason::Commands::session{'CurrentUser'};
            if ( $cu && $cu->id ) {
                my $pref = RT->Config->Get( 'TicketViewLayout', $cu );
                if ( $pref && $RT::Extension::SideBySideView::LAYOUTS{$pref} ) {
                    return $RT::Extension::SideBySideView::LAYOUTS{$pref};
                }
            }
        }

        return $orig->(%args);
    };
}

1;
