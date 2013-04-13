package ShantanuBhadoria::Site::Controller::Article;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

ShantanuBhadoria::Site::Controller::Article - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('article') :CaptureArgs(0){
    my ( $self, $c ) = @_;
}

=head2 index

=cut

sub index :Chained('base') :PathPart('') :Args(1) {
    my ( $self, $c, $article_alias ) = @_;
    my $article_id = $article_alias;
    $article_id =~ s/.*\-//;
    my $article_row = $c->model('DBIC::Article')->find($article_id);
    if( $article_row && $article_alias eq $article_row->url_alias . '-' . $article_id ){
        $c->stash(
              template     => 'article/index.tt',
              section_name => $article_row->title,
              article      => $article_row,
        );
    }
}

=head2 add

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
            template     => 'article/add.tt',
            section_name => 'Add Article',
        );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $form->submitted_and_valid ) {
        my $params = $c->req->params;
        my $article = $c->model('DBIC::Article')->new_result({});
        $form->model->update($article);

        my $article_title = lc $params->{title};
        $article_title =~ s/[^a-z0-9]+/\-/g;

        $article->url_alias($article_title);
        $article->update();
        $c->response->redirect($c->uri_for('/',
                {mid => $c->set_status_msg("Article Added")}));
        $c->detach;
    } else {
        $c->assets->include("css/form.css");
        $c->assets->include("tinymce/jscripts/tiny_mce/tiny_mce.js");
        $c->assets->include("js/form.js");
    }
}

=head2 list

=cut

sub list :Chained('base') :PathPart('list') :Args(0){ 
    my ( $self, $c ) = @_;
}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
