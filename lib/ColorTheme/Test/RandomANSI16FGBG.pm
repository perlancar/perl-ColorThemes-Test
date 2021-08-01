package ColorTheme::Test::RandomANSI16FGBG;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
use parent 'ColorThemeBase::Base';

our %THEME = (
    v => 2,
    summary => 'A color theme which gives random 16-color foreground+background ANSI codes',
    dynamic => 1,
    args => {
        cache => {
            schema => 'bool*',
            default => 1,
        },
        num => {
            schema => 'posint*',
            default => 5,
        },
    },
);

sub _rand_ansi16 {
    +{
        ansi_fg=>"\e[".(rand() < 0.5 ? 30+int(rand()*8) :  90+int(rand()*8))."m",
        ansi_bg=>"\e[".(rand() < 0.5 ? 40+int(rand()*8) : 100+int(rand()*8))."m",
    };
}

sub list_items {
    my $self = shift;

    my @list = 0 .. ($self->{args}{num}//5)-1;
    wantarray ? @list : \@list;
}

sub get_item_color {
    my ($self, $name, $args) = @_;
    if ($self->{args}{cache}) {
        return $self->{_cache}{$name} if defined $self->{_cache}{$name};
        $self->{_cache}{$name} = _rand_ansi16();
    } else {
        _rand_ansi16();
    }
}

1;
# ABSTRACT:

=head1 SYNOPSIS

Show a color swatch of this theme:

 % show-color-theme-swatch Test/RandomANSI16BG

Specify number of colors:

 % show-color-theme-swatch Test/RandomANSI16BG=num,10
