$envname = "dynamodb_env"

Write-Host "`nInstalling Python dependencies`n"
pip install virtualenv
python -m venv $envname
.\dynamodb_env\Scripts\Activate.ps1
pip install -r requirements.txt

Write-Host "`nDeploying local DynamoDB database`n" 
podman compose up -d --build --no-recreate --remove-orphans

Write-Host "`nCreating Table`n"
python create_table.py

Write-Host "`nTesting local DynamoDB connection`n"
aws dynamodb describe-table --endpoint-url "http://localhost:8000" --table-name Music | findstr TableStatus
aws dynamodb list-tables --endpoint-url "http://localhost:8000"
