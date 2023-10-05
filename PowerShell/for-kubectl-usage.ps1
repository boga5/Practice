#Installing Az Module
Install-Module -Name Az.Aks -Repository PSGallery

#connect to az-account
Connect-AzAccount

#Set a subscription to use. By default it uses the firs subscription
Set-AzContext -Subscription x1596exx-xx79-xxxx-xxxx-0197024f2051

#Didn't know the use of this
Import-AzAksCredential -ResourceGroupName rg-boga-tmp -Name aks-boga-tmp