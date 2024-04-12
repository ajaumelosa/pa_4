Create Strings as file list... soundFiles ../recordings/bi02/wavs/*.wav
select Strings soundFiles
numberOfFiles = Get number of strings

for i to numberOfFiles
	select Strings soundFiles
	soundName$ = Get string... i
	Read from file... ../recordings/bi02/wavs/*.wav/'soundName$'
	Scale peak... 0.99
	Write to binary file... ../recordings/bi02/wavs/*.wav/'soundName$'
	Remove
endfor