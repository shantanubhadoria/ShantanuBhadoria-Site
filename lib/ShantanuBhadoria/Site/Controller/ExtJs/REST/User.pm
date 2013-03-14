package ShantanuBhadoria::Site::Controller::ExtJs::REST::User;
use Moose;
use namespace::autoclean;

BEGIN {
    extends 'CatalystX::Controller::ExtJS::REST';
    with 'CatalystX::Controller::ExtJS::Direct';
}

=head1 NAME

ShantanuBhadoria::Site::Controller::ExtJs::REST::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
