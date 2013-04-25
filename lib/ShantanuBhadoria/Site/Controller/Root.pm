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

=head2 index

The root page (/)

=cut

sub base :Chained('/') :PathPart('') :CaptureArgs(0){
    my ( $self, $c ) = @_;
    $c->log->debug("In Base");
    $c->stash->{site_title} = 'Shantanu Bhadoria';
    $c->load_status_msgs;
    $c->assets->include("css/site.css");
    $c->assets->include("css/jquery.tagit.css");
    $c->assets->include("js/tag-it.js");
    $c->assets->include("js/tags.core.js");
}

=head2 base_json

=cut

sub base_json :Chained('/') :PathPart('') :CaptureArgs(0){
    my ( $self, $c ) = @_;
    $c->log->debug("In JSON Base");
    $c->stash->{current_view} = 'JSON';
}

=head2 index

=cut

sub index :Chained('/base') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;
    my $params = $c->req->params;
    $c->log->debug("In Index");

    $c->stash(
            template     => 'index.tt',
            section_name => 'Home',
        );
    my $articles = $c->model('DBIC::Article')->search(
        undef,
        {
            order_by => { 
                -desc => qw/id/,
            },
            page => $params->{page} || 1,
            rows => 10,
        },
    );
    $c->stash->{pagination} = $articles->pager();
    $c->stash->{articles}   = $articles;
}

=head2 default

Standard 404 error page

=cut

sub default {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
