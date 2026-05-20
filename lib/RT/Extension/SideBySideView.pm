package RT::Extension::SideBySideView;

use 5.10.1;
use strict;
use warnings;

our $VERSION = '3.00';

# Register the layout-split icon into RT's SVG config so GetSVGImage() works.
# Config is already loaded when Plugin() runs, and Get('SVG') returns the live hashref.
{
    my $svg = RT->Config->Get('SVG');
    if ( ref $svg eq 'HASH' ) {
        $svg->{'layout-split'} =
            '<path d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm8.5-1v12H14a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H8.5zm-1 0H2a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h5.5V2z"/>';
    }
}

$RT::Config::META{'TicketViewLayout'} = {
    Section         => 'Ticket display',
    Overridable     => 1,
    SortOrder       => 11,
    Widget          => '/Widgets/Form/Select',
    WidgetArguments => {
        Description => 'Ticket display layout',    # loc
        Values      => [ 'DefaultView', 'SideBySideView' ],
        ValuesLabel => {
            DefaultView    => 'Default (two-column metadata + history)',    # loc
            SideBySideView => 'Side by side (narrow metadata, wide history)',    # loc
        },
    },
};

# Layout definitions used by lib/RT/Interface/Web_Overlay.pm
our %LAYOUTS = (

    DefaultView => [
        {
            Title    => 'Ticket metadata',    # loc
            Layout   => 'col-md-6',
            Elements => [
                [
                    'Basics', 'Times', 'CustomFieldCustomGroupings',
                    'People', 'Attachments', 'Requestors',
                ],
                [
                    'Reminders', 'Articles', 'Dates',
                    'LinkedQueues', 'Assets', 'Links',
                ],
            ],
        },
        {
            Layout   => 'col-12',
            Elements => [ 'Description', 'History', 'LinkedTicketsHistory' ],
        },
    ],

    SideBySideView => [
        {
            Title    => 'Ticket Information',    # loc
            Layout   => 'col-md-3, col-md-9',
            Elements => [
                [
                    { HiddenRoles => [], Name => 'Basics' },
                    {
                        HiddenRoles => [ 'Change Reviewer', 'Change Implementor' ],
                        Name        => 'People',
                    },
                    'Dates',
                    'Times',
                    'Attachments',
                    'CustomFieldCustomGroupings:Default',
                    'Links',
                    'Requestors',
                    'Articles',
                    'Assets',
                    'LinkedArticles',
                ],
                [
                    {
                        FilterTxnTypes => [
                            'AddLink',               'AddWatcher',
                            'Comment',               'CommentEmailRecord',
                            'Correspond',            'Create',
                            'CustomField',           'DelWatcher',
                            'DeleteLink',            'EmailRecord',
                            'Forward Ticket',        'Forward Transaction',
                            'Set',                   'SetWatcher',
                            'Status',
                        ],
                        Name => 'History',
                    },
                ],
            ],
        },
        {
            Layout   => 'col-12',
            Elements => ['LinkedTicketsHistory'],
        },
    ],
);

=head1 NAME

RT::Extension::SideBySideView - Switchable ticket display layouts for RT 6

=head1 DESCRIPTION

Provides two named ticket display layouts for RT 6 and lets each user choose
between them via User Preferences or a per-ticket toggle button:

=over 4

=item DefaultView

Two-column metadata panel plus full-width Description and History below.

=item SideBySideView

Narrow metadata column (col-md-3) beside a wide History column (col-md-9).

=back

Users who have not set a preference continue to see RT's built-in default layout.

=head1 INSTALLATION

=over

=item C<perl Makefile.PL && make && sudo make install>

=item Add to F</opt/rt6/etc/RT_SiteConfig.pm>

    Plugin('RT::Extension::SideBySideView');

=item Clear Mason cache and restart Apache

    sudo systemctl stop apache2 \
      && sudo rm -rf /opt/rt6/var/mason_data/obj/* \
      && sudo systemctl start apache2

=back

=head1 AUTHOR

Torsten Brumm E<lt>technik@picturepunxx.deE<gt>

=head1 LICENCE

GPL version 2

=cut

1;
