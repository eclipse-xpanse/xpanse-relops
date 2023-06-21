<!-- This document outlines the steps taken, the timing, the choices made 
     to equip the Xpanse project with a set of processes and tools that
     implement a development environment open to anyone who wishes to
     contribute.                                                            -->

# Xpanse Open Development Setup

This document outlines the steps taken to make of the Xpanse project
an environment fully open to anyone who wishes to contribute. Agile
methodology best practices, Eclipse Foundation release checklists, available
tools, etc. have all been vetted and taken in account while developing this
document (at the time of writing, ndr, Jun 2023).

## Code Repository

### Proposing features
We welcome all new ideas that can make the project better. If you would like to propose a new feature to be added to 
the Xpanse project, you can start a new `discussion` in the Xpanse project [here](https://github.com/eclipse-xpanse/xpanse/discussions).
Also mark the discussion category as `ideas` and also tag the project members so that we can look into it without delays.

### Contributing changes and peer review

All changes can be contributed only via pull-requests. Details are available on
the [website](https://github.com/eclipse-xpanse/xpanse-website/blob/main/docs/Contribute/pull-requests.md)
PR can be reviewed and comments can be added by contributor but the PR can be approved only by one the project members
listed as `Committers` in Eclipse Foundation's Xpanse project setup.
List of these members can be found [here](https://projects.eclipse.org/projects/technology.xpanse/who).

## Milestones, issues and roadmap

## Development methodology
We follow agile develop methodology. All requirements are broken into user stories with short feedback cycle. 

But at the same time, we do not believe in going by the book of Scrum/Agile guidelines. We try to be as flexible as possible, 
avoid as much as meetings possible and focus mainly on shorter delivery cycles and feedback loops. 

### Sprints length
Each sprint starts on a Monday and is 2 weeks length. 

### Implemented agile methodology elements
Sprint planning - Happens every 2 weeks. 
Sprint reviews - Happens on alternate Monday's to review the Sprint progress.
Product Backlog - All requirements to backlog are added to the Xpanse project board. 
User stories - All requirements in the backlog is split into smaller user stories and created as GitHub `issues`
Self-Managing - We are a self-managing team, meaning we internally decide who does what, when, and how.
Definition of Done - We have a clear definition of done documented in every user story we implement. 

## Releases


### Latest release

Details about the latest Xpanse release can be found on the official Eclipse Foundation [Xpanse release page](https://projects.eclipse.org/projects/technology.xpanse/releases/1.0.0/plan)

### Intended release cadence

The Xpanse project aims at releasing a new major release once a year: a Spring release and a Fall release.
A major release can introduce new major functionalities and change APIs, thus obsoleting deprecated ones.

A minor release is meant for updates such as bug fixes and CVEs fixes and is not meant to break API compatibility.

### Intended lifecycle and end-of-life policy

The latest release is supported until a new major becomes available and for no less than 2 years even if a new major has become available.
This would allow developers and users enough time to plan for an upgrade.

### Issues and bugs handling, SLA, and bugs triage

## Compliance

### Cybersec

### IP compliance and FOSS licensing

## Quality and Assurance
We implement different levels of automated tests in our code base. 
1. Unit tests
2. Integrated tests using REST API mocks based on wiremock framework.

### Test plan

### Release criteria

Typical Xpanse release criteria that are gating a release of an upgrade or an update are:
- No critical bugs, CVEs, nor IP compliance issues are present
- 100% test coverage of all relevant roadmap features
- At least 95% pass rate
- A Software Bill of Material and test artifacts that accompany a release

## Community interaction

### Meeting tool

The Xpanse project preferably leverages [Jitsi](https://jitsi.org)  or, alternatively, Google Meet.

### Public chat channel

### Public calendar
We use public Google calendar to announce and track all events related to project. More details about the calendar can 
be found on the website [here](https://eclipse-xpanse.github.io/xpanse-website/docs/Contribute/calendar)
