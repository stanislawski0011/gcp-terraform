#!/bin/bash

# Check if project ID is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project-id>"
    exit 1
fi

PROJECT_ID=$1
BUCKET_NAME="terraform-state-${PROJECT_ID}"

# Create GCS bucket
gsutil mb -p ${PROJECT_ID} gs://${BUCKET_NAME}

# Enable versioning
gsutil versioning set on gs://${BUCKET_NAME}

# Set uniform bucket-level access
gsutil uniformbucketlevelaccess set on gs://${BUCKET_NAME}

# Get the current user's email
CURRENT_USER=$(gcloud config get-value account)

# Set IAM permissions for the current user
gcloud storage buckets add-iam-policy-binding gs://${BUCKET_NAME} \
    --member="user:${CURRENT_USER}" \
    --role="roles/storage.admin"

# Generate backend.tf configuration
cat > environments/dev/backend.tf << EOF
terraform {
  backend "gcs" {
    bucket = "${BUCKET_NAME}"
    prefix = "terraform.tfstate"
  }
}
EOF

echo "Created GCS bucket ${BUCKET_NAME} for Terraform state"
echo "Granted storage permissions to ${CURRENT_USER}"
echo "Generated backend.tf configuration"