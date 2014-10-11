require 'rest_client'
# This is the code that gets RUN at the scheduled time
# By the scheduled Iron.IO worker.
# When it is scheduled, a PAYLOAD will have been sent.

## Scheduled as follows:
## schedule = client.schedules.create('scheduledoutbound', payload, {:start_at => Time.now + 3600})

## Take in the self-initiated payload
## payload = {'contact_id'=> CONTACT_ID, 'sms_text'=> ACTIVATING_TEXT}
## Known ACTIVATING_TEXT:
## GRATITUDE CHECKIN

contact_id = params['contact_id']
sms_text = params['sms_text']

##
## rest is the same
