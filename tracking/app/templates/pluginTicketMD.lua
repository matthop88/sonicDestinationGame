return [[
---
ID: {{ id }}
Title: {{ title }}
Object Name: {{ objectName }}
Version: {{ version }}
Type: {{ type }}
Status: {{ status }}
Priority: {{ priority }}
Points: {{ points }}
Created: {{ createdAt }}
Updated: {{ updatedAt }}
Episode Created: {{ episodeCreated }}
Episode Due: {{ episodeDue }}
Labels: {{ labels }}
Blocked By: {{ blockedBy }}
---

# {{ id }}: {{ title }}

## Summary

{{ summary }}

## Details

{{ details }}

## Acceptance Criteria

{{ acceptanceCriteria }}

## Notes

The {{ objectName }} takes the following parameters:
{{ parameters }}

## History

{{ history }}
]]
