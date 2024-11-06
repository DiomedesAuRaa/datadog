import requests
import json
import os
import time

# Datadog API credentials
api_key = 'your_api_key'
app_key = 'your_application_key'

# Datadog API endpoints
base_url = 'https://api.datadoghq.com/api/v1/dashboard'
dashboards_url = f'{base_url}'

# Create an 'exports' folder if it doesn't exist
export_folder = 'exports'
os.makedirs(export_folder, exist_ok=True)

# Fetch the list of dashboards
response = requests.get(dashboards_url, headers={
    'DD-API-KEY': api_key,
    'DD-APPLICATION-KEY': app_key
})

# Initialize counters
exported_count = 0
failed_count = 0
skipped_count = 0

# Check for a successful response
if response.status_code == 200:
    dashboards = response.json()
    dashboard_ids = [dashboard['id'] for dashboard in dashboards.get('dashboards', [])]

    # Write the dashboard IDs to a JSON file in the 'exports' folder
    with open(os.path.join(export_folder, 'dashboard_ids.json'), 'w') as f:
        json.dump(dashboard_ids, f, indent=4)
    
    print("Dashboard IDs have been written to 'exports/dashboard_ids.json'")

    # Function to handle rate-limited requests with retries
    def fetch_dashboard_with_retry(dashboard_id, retries=5, backoff=1):
        dashboard_url = f'{base_url}/{dashboard_id}'
        for attempt in range(retries):
            response = requests.get(dashboard_url, headers={
                'DD-API-KEY': api_key,
                'DD-APPLICATION-KEY': app_key
            })

            if response.status_code == 200:
                return response.json()  # Return the dashboard data if successful
            elif response.status_code == 429:
                # Rate-limited, apply exponential backoff
                print(f"Rate limit hit for dashboard {dashboard_id}. Retrying in {backoff} seconds...")
                time.sleep(backoff)
                backoff *= 2  # Exponential backoff
            else:
                print(f"Failed to fetch dashboard {dashboard_id}: {response.status_code}")
                return None  # Return None if other error occurs
        return None  # Return None after retries if still failed

    # Now, fetch each dashboard by its ID and save to individual files in the 'exports' folder
    for dashboard_id in dashboard_ids:
        dashboard_file = os.path.join(export_folder, f"dashboard_{dashboard_id}.json")

        # Check if the file already exists, and skip if it does
        if os.path.exists(dashboard_file):
            print(f"Dashboard {dashboard_id} already exists. Skipping export.")
            skipped_count += 1
            continue
        
        # Fetch the dashboard if it doesn't exist
        dashboard_data = fetch_dashboard_with_retry(dashboard_id)
        
        if dashboard_data:
            # Save the dashboard to a JSON file
            with open(dashboard_file, 'w') as f:
                json.dump(dashboard_data, f, indent=4)
            print(f"Dashboard {dashboard_id} has been exported to {dashboard_file}")
            exported_count += 1
        else:
            print(f"Failed to fetch dashboard {dashboard_id} after retries")
            failed_count += 1

    # Print summary
    print("\nExport Summary:")
    print(f"Exported: {exported_count}")
    print(f"Failed: {failed_count}")
    print(f"Skipped: {skipped_count}")

else:
    print(f"Error fetching dashboards: {response.status_code}")
