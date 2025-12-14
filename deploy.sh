cd terraform

terraform init
terraform apply -auto-approve

if [ $? -ne 0 ]; then
  echo "Terraform apply failed"
  exit 1
fi

export BACKEND_USER=$(terraform output -raw backend_admin)
export BACKEND_IP=$(terraform output -raw backend_public_ip)
export DATABASE_IP=$(terraform output -raw database_public_ip)
export DATABASE_USER=$(terraform output -raw database_admin)
#if you dont want to use export variable to set password, uncomment below line and set your password
#export DATABASE_PASSWORD=YourStrongPassword

cd ..

cat > .backend_env <<EOL
DATASOURCE_URL=jdbc:mysql://${DATABASE_IP}:3306/eschool?useUnicode=true&characterEncoding=utf8
DATASOURCE_USERNAME=${DATABASE_USER}
DATASOURCE_PASSWORD=${DATABASE_PASSWORD}
EOL

cat > .database_env <<EOL
DATASOURCE_USERNAME=${DATABASE_USER}
DATASOURCE_PASSWORD=${DATABASE_PASSWORD}
EOL

scp -o StrictHostKeyChecking=no .backend_env setup_backend.sh auto_startup.sh ${BACKEND_USER}@${BACKEND_IP}:/home/${BACKEND_USER}/ 
scp -o StrictHostKeyChecking=no .database_env setup_database.sh ${DATABASE_USER}@${DATABASE_IP}:/home/${DATABASE_USER}/

ssh database <<'EOF'
chmod +x setup_database.sh
bash ./setup_database.sh
EOF

if [ $? -ne 0 ]; then
  echo "Database deployment failed"
  exit 1
fi

ssh backend <<'EOF'
chmod +x setup_backend.sh
bash ./setup_backend.sh
EOF

if [ $? -ne 0 ]; then
  echo "Backend deployment failed"
  exit 1
fi

echo "Deployment completed successfully"