use inc::Module::Install;

RTx('RT-Extension-SideBySideView-CustomView');

name            ('RT-Extension-SideBySideView-CustomView');
abstract        ('SideBySide Ticket View for RT');
author          ('Torsten Brumm <tbrumm@mac.com>');
version_from    ('lib/RT/Extension/SideBySideView/CustomView.pm');
license         ('GPL version 2');

&WriteAll;
