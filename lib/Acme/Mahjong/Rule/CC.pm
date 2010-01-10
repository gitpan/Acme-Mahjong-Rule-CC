package Acme::Mahjong::Rule::CC;

use 5.008008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Acme::Mahjong::Rule::CC ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 
'all' => [ qw(
	mahjong_table
	dealer
	nondealer
	draw
) ],
'tables' =>[qw(
	dealer
	nondealer
	draw
)] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.10';


sub mahjong_table{
   my $ans = 7;
   while($ans!=0 && $ans!=1 && $ans!=2){
      print("0.Nondealer , 1.Dealer, or 2.Draw : ");
      $ans=<STDIN>;
      }
   my @subs = (\&nondealer, \&dealer, \&draw);
   my @players = (qw/dealer player2 player3 player4/);
   $players[0]='winner' if ($ans != 2);
   $players[1]='dealer' if ($ans == 0);
   my @points;
   foreach $a(@players){
      print("$a : ");
      my $pts =<STDIN>;
      push @points,$pts;
   }
   print "===========================\n";
   foreach (&{$subs[$ans]}(@points)){
      my $p = shift @players;
      print "$p : $_\n";
   }
}
sub nondealer{
   my @score;
   my($w, $deal, $l2 , $l3)=@_;
   $score[0]=$w*4;
   $score[1]=4*$deal-(2*$w+2*$l2+2*$l3);
   $score[2]=3*$l2-($w+2*$deal+$l3);
   $score[3]=3*$l3-($w+2*$deal+$l2);
   @score;
}
sub dealer{
   my @score;
   my($w, $l2 ,$l3 ,$l4)=@_;
   $score[0]=$w*6;
   $score[1]=2*$l2-($w*2+$l3+$l4);
   $score[2]=2*$l3-($w*2+$l2+$l4);
   $score[3]=2*$l4-($w*2+$l3+$l2);
   @score;
}
sub draw{
   my @score;
   my($l1, $l2 ,$l3 ,$l4)=@_;
   $score[0]=$l1*6-2*($l2+$l3+$l4);
   $score[1]=$l2*4-($l1*2+$l3+$l4);
   $score[2]=$l3*4-($l1*2+$l2+$l4);
   $score[3]=$l4*4-($l1*2+$l3+$l2);
   @score;
}

1;
__END__


=head1 NAME

Acme::Mahjong::Rule::CC - Exchange Tables for a Classic Chinese Version of Mahjong.

=head1 DESCRIPTION

Tables the exchanges of a round of mahjong based off of the given scores.
This module mainly applies to the Classic Chinese version of the game, where
every hand is scored, not just the winners.  Players pay each other the value
of the other's hand, dealer pays and recieves double, and winner pays no one.


=head1 SYNOPSIS

  use Acme::Mahjong::Rule::CC;
  mahjong_table() starts a premade user interface;
  nondealer($winner_pts, $dealer_pts, $player3_pts, $player4_pts)
        returns the exchanges of the given scores
        when the winner is a non-dealer
        majong::nondealer(200,100,0,0);
        #this returns (800,0,-400,-400)
  dealer(winner, player2, player3, player4)
        returns the exchanges of the given scores
        when the dealer is the winner
        majong::dealer(200,100,0,0);
        #this returns (1200,-200,-500,-500)
  draw(dealer, player2, player3, player4)
        returns the exchanges of the given scores
        when there is no winner in the form of an
        array.
        majong::draw(200,100,0,0);
        #this returns (1000,-200,-400,-400)

=head2 EXPORT

None by default.



=head1 SEE ALSO

Acme::Mahjong::Rule::JP

=head1 AUTHOR

root, E<lt>cjveenst@mtu.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by TROTSKEY

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
