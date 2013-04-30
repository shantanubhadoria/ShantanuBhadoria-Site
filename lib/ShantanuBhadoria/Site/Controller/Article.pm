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
    $c->stash->{current_view} = 'TT';
}

=head2 index

=cut

sub index :Chained('base') :PathPart('') :Args(1) {
    my ( $self, $c, $article_alias ) = @_;
    my $article_id = $article_alias;
    $article_id =~ s/.*\-//;
    my $article_row = $c->model('DBIC::Article')->find($article_id,
        {
            prefetch => {
                article_tag_maps => 'tag'
            },
        },
    );
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

    if( !$c->check_user_roles('admin') ) {
        $c->response->redirect($c->uri_for('/',
                {mid => $c->set_error_msg("Log in first fuck face!!")}));
        return;
    }

    $c->stash(
            template     => 'article/add.tt',
            section_name => 'Add/Edit Article',
        );
    my $params = $c->req->params;

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $form->submitted_and_valid ) {
        my $article;
        if($params->{article_id}) {
            $article = $c->model('DBIC::Article')->find($params->{article_id});
        } else {
            $article = $c->model('DBIC::Article')->new_result({});
        }
        $form->add_valid(author_id=>$c->user->id);
        $form->model->update($article);

        my $article_title = lc $params->{title};
        $article_title =~ s/[^a-z0-9]+/\-/g;

        $article->url_alias($article_title);
        $article->update();
        if($params->{article_id}) {
            $c->response->redirect($c->uri_for('/article/' . $article->url_alias . '-' . $article->id,
                    {mid => $c->set_status_msg("Article Modified")}));
        } else {
            $c->response->redirect($c->uri_for('/',
                    {mid => $c->set_status_msg("Article Added")}));
        }
        $c->detach;
    } else {
        $c->log->debug("Fetching Article " . $params->{article_id});
        if($params->{article_id}) {
            $form->model->default_values(
                $c->model('DBIC::Article')->find($params->{article_id})
            );
        }
        $c->assets->include("tinymce-4.0b2/js/tinymce/tinymce.min.js");
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
