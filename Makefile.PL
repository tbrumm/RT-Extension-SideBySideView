use inc::Module::Install;

RTx('RT-Extension-SideBySide-CustomView');

name            ('RT-Extension-SideBySide-CustomView');
abstract        ('SideBySide Ticket View for RT');
author          ('Torsten Brumm <tbrumm@mac.com>');
version_from    ('lib/RT/Extension/SideBySideView/CustomView.pm');
license         ('GPL version 2');

&WriteAll;
