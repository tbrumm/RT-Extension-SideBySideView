use inc::Module::Install;

RTx('RT-Extension-SideBySideView');
license('gpl_2');
author('Torsten Brumm <technik@picturepunxx.de>');
version_from('lib/RT/Extension/SideBySideView.pm');
requires_rt('6.0.0');
rt_too_new('7.0.0');
WriteAll();
