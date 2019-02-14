#!/usr/bin/env perl
use strict;
use warnings;

use PDF::API2;
use PDF::Table;

my $data =[
    ["1 Lorem ipsum dolor1 Lorem ipsum dolor1 Lorem ipsum dolor 1 Lorem ipsum dolor1 Lorem ipsum dolor", "x", "bbbbbbb dfgdfg dfgdfgdfg dfgdfg"],
    ["2 Lorem ipsum dolor Donec odio neque, faucibus vel consequat quis, tincidunt vel, felis."],
    ["Nulla euismod sem eget neque.", "Donec odio neque sed eu velit."],
];

my @required = (
      x => 10,
      w => 260,
      start_y => 750,
      start_h => 400,
      padding => 5,
);

{
    use PDF::API2;
    my $pdftable = new PDF::Table;
    my $pdf      = new PDF::API2( -file => "colspan.pdf" );
    my $page     = $pdf->page();
    $pdf->mediabox('A4');

    $pdftable->table($pdf, $page, $data, @required,
        column_props=>[
            { min_w=>150, background_color => 'grey'},
            { background_color => 'red'},
            { }
        ],
        cell_props => [
                [ {}, { background_color => 'pink'}, { background_color => 'blue', colspan=>1 } ],
                [ { colspan=>3 }, {}, {} ],
                [ {}, { colspan=>2 }, {}],
        ],
    );
    $pdf->saveas();
}
