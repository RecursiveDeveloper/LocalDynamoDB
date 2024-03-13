$env_name = "dynamodb_env"
$local_endpoint = "http://localhost:8000"
$table_name = "Music"

Write-Host "`nSetting up Python Virtual Environment $env_name`n"
pip install virtualenv
python -m venv $env_name
.\dynamodb_env\Scripts\Activate.ps1

Write-Host "`nInstalling Python dependencies`n"
pip install -r requirements.txt

Write-Host "`nDeploying local DynamoDB database`n" 
podman compose up -d --build --no-recreate --remove-orphans

Write-Host "`nCreating Table`n"
python create_table.py $local_endpoint $table_name

Write-Host "`nAdding data into $table_name table`n"
python put_items.py $local_endpoint $table_name

Write-Host "`nTesting local DynamoDB connection`n"
aws dynamodb describe-table `
    --endpoint-url $local_endpoint `
    --table-name $table_name | findstr TableStatus
    
aws dynamodb list-tables --endpoint-url $local_endpoint
aws dynamodb scan --endpoint-url $local_endpoint --table-name $table_name
