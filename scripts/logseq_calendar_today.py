#!/usr/bin/env python3

from __future__ import print_function
import datetime
import os.path
import re
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.discovery import build

# If modifying these SCOPES, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']

def remove_html_tags(text):
    """Remove HTML tags from a string and replace them with a single space."""
    # Regex to match HTML tags
    clean = re.compile('<.*?>')

    # Replace HTML tags with a space
    text_with_spaces = re.sub(clean, ' ', text)

    # Replace multiple spaces with a single space
    cleaned_text = re.sub(r'\s+', ' ', text_with_spaces)

    # Strip leading and trailing spaces
    return cleaned_text.strip()

def main():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is created automatically
    # when the authorization flow completes for the first time.
    if os.path.exists('/tmp/token.json'):
        creds = Credentials.from_authorized_user_file('/tmp/token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                '/etc/credentials-google', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('/tmp/token.json', 'w') as token:
            token.write(creds.to_json())

    service = build('calendar', 'v3', credentials=creds)

    # Define the time range for today (midnight to midnight)
    today = datetime.datetime.utcnow().date()
    start_of_day = datetime.datetime(today.year, today.month, today.day, 0, 0, 0).isoformat() + 'Z'
    end_of_day = datetime.datetime(today.year, today.month, today.day, 23, 59, 59).isoformat() + 'Z'

    events_result = service.events().list(calendarId='primary', timeMin=start_of_day,
                                          timeMax=end_of_day,
                                          singleEvents=True,
                                          orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        print('No events found for today.')
    for event in events:
        # Exclude "Syncing" and "Lunch" meetings
        summary = event.get('summary', '')
        if summary in ["Syncing","Lunch","Home","Out of office","Planning / Comms / Jira"]:
            continue

        start = event['start'].get('dateTime', event['start'].get('date'))

        # Extract the time portion from the start time
        start_time = datetime.datetime.fromisoformat(start).time().strftime('%H:%M')
        print(f"\t\t\t- **{start_time}** {event['summary']}\n\t\t\tcollapsed:: true")

        description = event.get('description', 'XXX')
        clean_description = remove_html_tags(description)

        attendees = event.get('attendees', [])
        if attendees:
            print("\t\t\t\t- **Attendees**")
            for attendee in attendees:
                email = attendee.get('email')
                name = attendee.get('name')
                response_status = attendee.get('responseStatus')
                print(f"\t\t\t\t\t- {email} (**{response_status}**)")
        if description != 'XXX':
            print(f"\t\t\t\t- **Description**")
            print(f"\t\t\t\t\t- {clean_description}")
        print(f"\t\t\t\t- **Notes**")
        print(f"\t\t\t\t\t- XXX")
        print(f"\t\t\t\t- **Questions**")
        print(f"\t\t\t\t\t- XXX")
        print(f"\t\t\t\t- **Actions**")
        print(f"\t\t\t\t\t- XXX")

if __name__ == '__main__':
    main()
