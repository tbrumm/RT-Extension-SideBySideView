package RT::Extension::SideBySideView::CustomView;

our $VERSION = '0.02';

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
