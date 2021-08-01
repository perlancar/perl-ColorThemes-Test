package ColorTheme::Test::RandomANSI256FGBG;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
use parent 'ColorThemeBase::Base';

our %THEME = (
    v => 2,
    summary => 'A color theme which gives random 256-color background ANSI codes',
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

sub _rand_ansi256 {
    +{
        ansi_fg=>"\e[38;5;".int(rand()*256)."m",
        ansi_bg=>"\e[48;5;".int(rand()*256)."m",
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
        $self->{_cache}{$name} = _rand_ansi256();
    } else {
        _rand_ansi256();
    }
}

1;
# ABSTRACT:

=head1 SYNOPSIS

Show a color swatch of this theme:

 % show-color-theme-swatch Test/RandomANSI256BG

Specify number of colors:

 % show-color-theme-swatch Test/RandomANSI256BG=num,10
