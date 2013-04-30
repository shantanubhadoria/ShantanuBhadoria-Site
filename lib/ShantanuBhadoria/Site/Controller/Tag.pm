package ShantanuBhadoria::Site::Controller::Tag;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShantanuBhadoria::Site::Controller::Tag - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('tag') :CaptureArgs(0){
    my ( $self, $c ) = @_;
}

=head2 index 

=cut

sub index :Chained('base') :PathPart('') :Args(1) {
    my ( $self, $c, $tag ) = @_;
    my $params = $c->req->params;
    $c->log->debug("In Index");

    $c->stash(
            template     => 'index.tt',
            section_name => $tag,
        );
    my $articles = $c->model('DBIC::Article')->search(
        {
            'article_tag_maps.tag' => $tag,
        },
        {
            join     => 'article_tag_maps',
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

=head2 base_json

=cut

sub base_json :Chained('/base_json') :PathPart('tag') :CaptureArgs(0){
    my ( $self, $c ) = @_;
}

=head2 list 

=cut

sub list :Chained('base_json') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;
    my @tags = $c->model('DBIC::Tag')->all;
    $c->stash->{json} = [ map { $_->tag } @tags ];
}

=head2 add 

=cut

sub add :Chained('base_json') :PathPart('add') :Args(0) {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;
    $c->model('DBIC')->txn_do( sub {
            my $tag = $c->model('DBIC::Tag')->find_or_create({
                    tag => $params->{tag},
                });
            $tag->add_to_article_tag_maps({
                    article_id => $params->{article_id}
                });
        });
    $c->stash->{json} = {
        success => 1,
    };
}

=head2 del 

=cut

sub del :Chained('base_json') :PathPart('del') :Args(0) {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;
    my $tag = $c->model('DBIC::ArticleTagMap')->find({
            article_id => $params->{article_id},
            tag        => $params->{tag},
        })->delete;
    $c->stash->{json} = {
        success => 1,
    };
}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
