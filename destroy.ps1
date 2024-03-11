$envname = "dynamodb_env"

Write-Host "`nDeactivating Python Environment`n"
deactivate
Remove-Item -Recurse -Force .\$envname\

Write-Host "`nDestroying local DynamoDB database`n" 
podman compose down --rmi all -v --remove-orphans
