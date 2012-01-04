package ShantanuBhadoria::Site::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');


=head1 NAME

ShantanuBhadoria::Site::Controller::Root - Root Controller for ShantanuBhadoria::Site

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 js

Serve minified js for everyone at /js

=cut

sub js : Local {
    my ( $self, $c ) = @_;

    # loads root/js/script1.js and root/js/script2.js
    $c->stash->{js} = [qw/js_head site_renderer/];

    $c->forward('View::JavaScript');
}

=head2 css

Serve minified CSS for everyone at /js

=cut

sub css : Local {
    my ( $self, $c ) = @_;

    # load root/css/style1.css and root/css/style2.css
    $c->stash->{css} = [qw/style1 style2/];

    $c->forward("View::CSS");
}


=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $req = $c->req;

    # Hello World
    #$c->response->body( $c->welcome_message );
    $c->stash->{template} = 'index.tt';
    $c->stash->{site_title} = 'Shantanu Bhadoria';
    $c->stash->{base_url} = $req->base;
    $c->stash->{service_url} = $req->base . 'service/';
    $c->forward($c->view('Web'));
}

=head2 service

service to provide data to render the pages

=cut

sub service :Local {
    my($self, $c) = @_;
    $c->stash(result => {a=>'b'});
    $c->forward('View::JSON');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Shantanu Bhadoria

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
