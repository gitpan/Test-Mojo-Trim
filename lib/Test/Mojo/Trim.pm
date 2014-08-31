package Test::Mojo::Trim;

use strict;

use Mojo::Base 'Test::Mojo';
use Mojo::Util 'squish';
our $VERSION = '0.03';

sub trimmed_content_is {
    my $self = shift;
    my $value = squish(Mojo::DOM->new(shift)->to_string);
    my $desc = shift;

    my $got = squish($self->tx->res->dom->to_string);
    $value =~ s{> <}{><}g;
    $got =~ s{> <}{><}g;
    $desc ||= 'exact match for trimmed content';

    return $self->_test('is', $got, $value, $desc);
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Mojo::Trim - Test::Mojo expanded

=head1 SYNOPSIS
    
    use Mojo::Base -strict;
    use Mojolicious::Lite;
    use Test::More;
    use Test::Mojo::Trim;

    my $test = Test::Mojo::Trim->new;

    get '/test_1';

    my $compared_to = qq{ <div><h1>Header</h1><p>A paragraph.</p></div> };

    $test->get_ok('/test_1')->status_is(200)->trimmed_content_is($compared_to);
    
    done_testing();

    __DATA__
    @@ the_test.html.ep
    <div>
        <h1>Header</h1>
        <p>A paragraph.</p>
    </div>

=head1 DESCRIPTION

Test::Mojo::Trim is an extension to Test::Mojo, that adds an additional string comparison function.

=head1 METHODS

L<Test::Mojo::Trim> inherits all methods from L<Test::Mojo> and implements the following new one.

=head2 trimmed_content_is

    $test->get_ok('/test')->trimmed_content_is('<html></html>');

Removes all whitespace between tags from the two strings that are compared. 
That is, if a E<gt> and E<lt> is separated only by whitespace, that whitespace is removed.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014- Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=over 4

=item *

L<Test::Mojo>

=item *

L<Test::Mojo::Most>

=back

=cut
