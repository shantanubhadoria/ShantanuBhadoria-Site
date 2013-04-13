package ShantanuBhadoria::Site::Model::Article;

use Moose;
use namespace::clean -except => 'meta';

extends 'Catalyst::Model';

=head1 NAME

ShantanuBhadoria::Site::Model::Article - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
