package ColorTheme::Test::Random;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
use parent 'ColorThemeBase::Base';

use Color::RGB::Util qw(rand_rgb_color);

our %THEME = (
    v => 2,
    summary => 'A color theme which gives random colors',
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
        # TODO: whether to set random foreground color or not (default 1)
        # TODO: whether to set random background color or not (default 0)
    },
);

sub list_items {
    my $self = shift;

    my @list = 0 .. ($self->{args}{num}//5)-1;
    wantarray ? @list : \@list;
}

sub get_item_color {
    my ($self, $name, $args) = @_;
    if ($self->{args}{cache}) {
        return $self->{_cache}{$name} if defined $self->{_cache}{$name};
        $self->{_cache}{$name} = rand_rgb_color();
    } else {
        rand_rgb_color();
    }
}

1;
# ABSTRACT:
