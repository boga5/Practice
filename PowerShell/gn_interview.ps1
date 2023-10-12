#Zip a file
#unzip a file and add a column
#iterating through an array of objects and displaying them
#add to an existing array
#display array contents using foreach
#display tree structure in of current folder, previous folder, before that and so on upto n levels
#get the user, display tree structure of their home folder, compress a file
#try & catch blocks

Compress-Archive -Path C:\Users\bogas\Documents\sample.xls -DestinationPath C:\Users\bogas\Documents\

Expand-Archive -Path C:\Users\bogas\Documents\.zip -DestinationPath C:\Users\bogas\Documents\sample2.xls

Get-ChildItem -Recurse C:\

Get-ADUser -Upn sample@example.com 
Get-ChildItem -Recurse C:\$User\
Compress-Archive -Path C:\$User\password.txt -DestinationPath C:\
Expand-Archive 

New-Item -ItemType Array
count=array.length

for-each in count

Add-Object