#! /usr/bin/env perl

use strict;
use warnings;

sub bold {
	my ($text) = @_;
	return "<b>$text</b>";
}

sub newline {
	my ($text) = @_;
	return "$text<br/>";
}
sub cpar {
	my ($text) = @_;
	return "<P align=\"center\">$text</P>";
}
sub par {
	my ($text) = @_;
	return "<P>$text</P>";
}
sub nl {
	my ($text) = @_;
	return "$text\n";
}

print nl("<P align=\"center\">");

my $count=0;
my $education_count = -1;
my $job_count = -1;

while (my $line = <STDIN>) {
	chomp $line;
	if ($line =~ /^$/) {
		next;
	}
	if ($line =~ /^\*\*/) {
		$line =~ s/\*\*//g;                    # Remove all '**'
		
		# End processing for a section
		if ($count == 4) {
			print nl("</ul>");
			print nl("</P>");
		}
		if ($count == $education_count) {
			print nl("</ul>");
			print nl("</P>");
		}
		 
		# Process new section 
		$count++;
		if ($count == 1) {                     # Start
			print nl(newline(bold($line)));
			next;
		}
		if (($count == 2) || ($count == 3)) {  # Experience && Current
			print nl(cpar(bold($line)));
			next;	
		}
		if ($count == 4) {                     # Skills 
			print nl("<P>");
			print nl(bold($line));
			print nl("<ul>");
			next;
		}
		if ($count == 5) {                     # Certifications
			print nl("<P>");
			print nl(bold($line));
			print nl("<ul>");
			next;
		}
		# Job history and On Contract lines below

		# Education
		if ($line =~ /^Education/) {
			print nl("<P>");
			print nl(bold($line));
			print nl("<ul>");
			$education_count = $count;
			$job_count = -1;
			next;
		}

		# Clearances
		if ($line =~ /^Clearances/) {
			print nl(newline(bold($line)));
			$education_count = -1;
			$job_count = -1;
			next;
		}

		# On Contract lines
		if ($line =~ /^On contract for/) {
			print nl(newline(bold($line)));
	        	$job_count = $count; 	
			next;
		}
		# Job history
		print nl(newline(bold($line)));
	        $job_count = $count; 	
		next;	
		
	}
	# Continue line processing for a section (^**)
	if ($count == 1) {
		print nl(newline($line));
	}
	if ($count == 4) {
	        $line =~ s/^- +//;	
		print nl("<li>".$line);
	}
	if ($count == 5) {
		if ($line =~ /credly/) {
			print nl("</ul>");
			print nl($line);
			print nl("</P>");
		} else {
			print nl("<li>".$line);
		}
	}
	if ($count == $education_count) {
		print nl("<li>".$line);
	}
	if ($count == $job_count) {
		print nl(newline("&nbsp;&nbsp;&nbsp;&nbsp;".$line));
	}

		
}

