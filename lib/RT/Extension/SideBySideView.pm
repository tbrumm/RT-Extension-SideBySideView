package RT::Extension::SideBySideView;

use 5.008003;
use strict;
use warnings;

our $VERSION = '0.03';

$RT::Config::META{'SideBySideView'} = {
    Section         => 'RT::Extension::SideBySideView',
    Overridable     => 1,
    SortOrder       => 1,
    Widget          => '/Widgets/Form/Boolean',
    WidgetArguments => {
        Description => 'SideBySideView', # loc
    },
};

1;

__END__

=head1 NAME

RT::Extension::SideBySideView - SideBySide Ticket View for RT

=head1 SYNOPSIS

Based on an original Idea from Steve Turner (MIT) and Markus Dirr (GreenCircle)
and the ground work of Thomas Sibley (BestPractical) and some Ideas from BPS
Wiki this AddOn will give you the option to change the Ticket View from
original BPS View to a so called SideBySide Ticket View (known from wiki).

=head1 INSTALLATION

	1. Run "perl Makefile.PL"

	2. Run "make"

	3. Run "make install" (you may need root permissions)

	4. Additionally, if you're running 3.8, you'll need to add
	"RT::Extension::SideBySideView" to @Plugins in
	etc/RT_SiteConfig.pm.  For example:
	Set( @Plugins, qw(RT::Extension::SideBySideView) );

	6. Clear RT's mason cache and restart the web server to make sure the
	extension is incorporated.

=head1 AUTHOR

	Torsten Brumm <tbrumm@mac.com>
	Christian Loos <cloos@netsandbox.de>

=head1 LICENCE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 THANKS

	Steve Turner (MIT)
	Markus Dirr (GC)
	Thomas Sibley (BPS)
	Christian Loos (NetCologne)

=cut
