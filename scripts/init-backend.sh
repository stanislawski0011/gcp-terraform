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

echo "Created GCS bucket ${BUCKET_NAME} for Terraform state"