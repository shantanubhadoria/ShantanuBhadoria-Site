package ShantanuBhadoria::Site::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

use TryCatch;

=head1 NAME

ShantanuBhadoria::Site::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('user') :CaptureArgs(0) {
}

=head2 add 

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
            template     => 'user/add.tt',
            section_name => 'User Registration',
        );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $form->submitted_and_valid ) {
        my $user = $c->model('Schema::User')->new_result({});
        $form->model->update($user);
        $c->response->redirect($c->uri_for($self->action_for('add'),
                {mid => $c->set_status_msg("Registration Successful")}));
        $c->detach;
    } else {
        $c->assets->include("css/form.css");
        $c->assets->include("js/form.js");
        $c->assets->include("extjs/resources/css/ext-all.css");
        $c->assets->include("extjs/ext-debug.js");
        $c->assets->include("js/user.js");
    }
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ShantanuBhadoria::Site::Controller::User in User.');
}


=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
