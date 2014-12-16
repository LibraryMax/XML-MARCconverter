#This is an plain XML to XMLMARC converter.
#Copyright (C) <2014>  <Max Cohen>
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.


 print "hello";


$inputname = $ARGV[0];
$outputname = $ARGV[1];



print $inputname;

open (MYFILE, $inputname);
 while (<MYFILE>) {
 	chomp;

#print "$_\n";
$perline = $_;

open (MYFILE, ">>$outputname");

#start add header

print MYFILE "<collection> \n";

#start find records
while ($perline =~ /<record>(.+?)<\/record/g)
{
print "found record $1\n\n";
$perline2 = $1;

print MYFILE "<record> \n";

print MYFILE "<datafield tag=\"041\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">eng</subfield> \n </datafield> \n";


#end add header



#start Author Finder


$header = "100";
$backupheader = "700";
my $first = 1;

while ($perline2 =~ /<author>(.+?)<\/author/g)

{
if ($first == 1)
{
print "found";
print MYFILE "<datafield tag=\"100\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";




"$header$1\n";
$first = 2;
}
else
{
print MYFILE print MYFILE "<datafield tag=\"700\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}


}

# end author finder

$header = "245__ \$\$a";

while ($perline2 =~ /<title>(.+?)<\/title/g)

{

print MYFILE "<datafield tag=\"245\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}

$header = "260__ \$\$a";

while ($perline2 =~ /<year>(.+?)<\/year/g)

{

print MYFILE "<datafield tag=\"260\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}

$header = "300__ \$\$a";

while ($perline2 =~ /<pages>(.+?)<\/page/g)



$header = "4901_ \$\$a";

while ($perline2 =~ /<secondary-title>(.+?)<\/secondary-title/g)

{

print MYFILE "<datafield tag=\"490\" ind1=\"1\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}



$header = "520__ \$\$a";

while ($perline2 =~ /<abstract>(.+?)<\/abstract/g)

{

print MYFILE "<datafield tag=\"520\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}

$header = "6531_ \$\$a";

while ($perline2 =~ /<keyword>(.+?)<\/keyword/g)

{

print MYFILE "<datafield tag=\"653\" ind1=\"1\" ind2=\"_\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}

$header = "909C4 \$\$a";

while ($perline2 =~ /<electronic-resource-num>(.+?)<\/electronic-resource-num/g)

{

print MYFILE "<datafield tag=\"909\" ind1=\"C\" ind2=\"4\"> \n <subfield code=\"a\">$1</subfield> \n </datafield> \n";
}

#start PDF Finder

my $first = 1;

while ($perline2 =~ /<url>internal-pdf:\/\/(.+?)<\/url>/g) # find a pdf name

{
if ($first == 1)
{
print "found pdf: $1\n";

print MYFILE "<datafield tag=\"FFT\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">\/tmp\/files\/$1</subfield> \n <subfield code=\"t\">Main</subfield> \n </datafield> \n";


$first = 2;
}
else
{

print MYFILE "<datafield tag=\"FFT\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">\/tmp\/files\/$1</subfield> \n <subfield code=\"t\">Additional</subfield> \n </datafield> \n";
}

}
# end find pdf name

print MYFILE "<datafield tag=\"980\" ind1=\"_\" ind2=\"_\"> \n <subfield code=\"a\">ARTICLE</subfield> \n </datafield> \n";

#end other fields

print MYFILE "</record> \n\n"; 
 	
}#end find record


print MYFILE "</collection> \n";

}#end main loop


close (MYFILE);

