# talmud-bavli-text

Talmud Bavli from Mechon Mamre, converted from original htm files to txt files.
Tremendous gratitude to all those who worked on the Mechon Mamre version. 

I needed a copy of the Talmud Bavli that I could work with. So here it is.

mechon_mamre_converter.rb - ruby conversion program. requires making base directories before use. will error nicely. appends to files, does not rewrite them from scratch, so be sure to delete old output files before running. Output files can be found here. No need to run this.

l002.zip - Original zip from mechon mamre. Can be found online at: https://www.mechon-mamre.org/htmlzips/l002.zip

htm/ - Extracted contents from the original mechon mamre zip file.

txts/ - Simple conversion to txt files. Added colons to the initial, originally bold, headings "גמרא:" and "משנה:" for clarity. RTL appears wonky here on github, but the text should be good. Renamed dappim based on their gematrias, for easier sorting. There is not supposed to be a page "1". Moved out the seperate perek entries to txt_by_perek.

txt_by_perek/ - Moved into here the redundant sections that were broken up by perakim. Not necessary.

clean_txts/ - Clean is relative. The attempt is to make the mechon mamre texts closer to the standard texts. Changed "גמרא" to "גמ'" and "משנה" to "מתני'". Removed verse references. The curly braces "{" and "}" seem to imply non standard additions, and were removed along with everything in between. "<" and ">" in the Mechon Mamre version seem be the equivilant of "(", ")" in the standard text and were substituted with the latter. Sometimes they mean to remove words from the standard as the curly braces "{" and "}" were meant to insert words. Without checking each phrase, these were left as "()".

torah_or/ - a list of the quotations that were referenced on each amud. Sorry, just book and chapter number, no verse number.

toldos_aharon.csv - an index of all the quotations in the talmud. Sorry, just book and chapter number, no verse number.

The accuracy of this work hinges entirely on the accuracy and consistancy of the Mechon Mamre version. (And obviously the accuracy of my conversions.)

