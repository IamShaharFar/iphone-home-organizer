---
name: iphone-home-organizer
description: Plan and, after explicit approval, organize an iPhone Home Screen through Apple's iPhone Mirroring on a Mac when the current Codex environment already has suitable Computer Use tools. Use for arranging Home Screen apps, folders, and existing widgets; otherwise provide a planning-only workflow.
---

# iPhone Home Organizer

**Requires Computer Use:** Applying changes needs an already authorized Codex environment that can see and control the native Mac iPhone Mirroring window, including supported drag gestures. This skill does not provide or enable Computer Use; an ordinary CLI installation alone is insufficient. If that capability is absent, use planning only.

Build a personalized, approved Home Screen layout without deleting apps or changing their data or device settings. Respond in the user's language.

**Status:** Portable prototype. This package has not been tested on a device. It contains instructions, not a GUI-control driver. A user's report that a similar workflow worked is not verification of this package or another person's setup.

## 1. Establish capability and scope

- Inspect the tools actually available in the current environment and follow their documentation. Applying a layout requires the ability to observe and control the native Mac iPhone Mirroring window, including supported click-and-hold/drag gestures and fresh observations afterward. A browser-only tool, shell, or generic Codex CLI installation does not establish that capability. Do not invent tool names, commands, endpoints, or hidden iOS configuration APIs.
- Ask the user to open Apple's **iPhone Mirroring**, complete setup/authentication themselves, and confirm the intended iPhone. Never ask for or enter passwords, passcodes, or authentication codes. Do not change authentication choices, permissions, accounts, or security settings to make this work.
- Consult [Apple's current requirements and availability](https://support.apple.com/en-us/120421) when troubleshooting compatibility. At drafting time: Apple silicon or T2 Mac, macOS 15+, iOS 18+ with a passcode, the same Apple Account with two-factor authentication, Wi-Fi and Bluetooth enabled, and a nearby locked iPhone; other restrictions and regional availability apply. Do not install updates or change system settings as part of organizing.
- If the Mac is off, mirroring is unavailable, or required control is unsupported, clearly select **planning only**. Use a user-provided app list or optional privacy-reviewed screenshots; mark missing information unknown. Do not imply a proposed layout was applied or keep retrying an unavailable connection.

## 2. Personalize briefly

Ask only what is not already known, ideally in one short message:

1. Which apps deserve immediate access, and what should never move?
2. Should the Dock stay exactly as it is? Which widgets must remain?
3. Prefer a few themed folders or mostly visible icons? What folder language/names and approximate page count feel right?

Use the user's priorities, not assumptions about usage based on app names. Default to preserving the Dock, existing widgets, familiar first-page anchors, and folder names until the user chooses otherwise. Do not inspect app contents or Screen Time to guess preferences.

## 3. Inventory before editing

With permission to inspect, navigate the visible Home Screen pages without entering edit mode. Record each page's apps, folders, existing widget footprints, empty spaces, and the Dock. Identify positions by page and observed row/column or clear visual anchors; account for interface language, icon size, and widget spans rather than assuming a fixed grid. Open only folders needed for the agreed scope, not apps, and record their internal pages when relevant.

Distinguish duplicate icons by location. Do not treat them as redundant apps. Label ambiguous icons and unseen folder contents as unknown. Visible pages are not a complete installed-app inventory: leave hidden pages, hidden apps, and Focus-specific visibility untouched.

Keep a compact before-state and change ledger in the current task. Screenshots, if available, are visual records, **not restorable backups**. Do not promise full restoration or one-click undo. Avoid saving additional screenshot files unless requested. Do not upload or publish screenshots, inventories, widget content, or notifications for sharing; the portable skill must contain no user's personal layout data.

## 4. Propose an exact change set; wait for approval

Show the target layout by page and folder, then a concrete before → after list:

- Each app/widget move, with source and destination.
- Every folder creation or rename and its exact contents; note if moving the last item will remove an empty folder.
- Dock changes only if the user chose them; explicitly list protected items staying put.
- Expected icon reflow, new pages, or disappearance of an empty page caused by these moves.

Resolve ambiguous labels, destinations, or folder membership before applying. Prefer fewer moves and preserve muscle memory. Do not promise an exact page count if the observed widget/grid capacity cannot support it.

Ask explicitly: **“Apply this exact layout?”** A general request to organize, approval to inspect, or silence is not approval to apply the proposed change set. A materially revised plan needs fresh approval. In planning-only mode, deliver the proposal and manual steps instead of asking as though remote execution is available.

## 5. Apply in small, observable batches

Only after explicit approval:

1. Obtain a fresh view of the intended window and starting layout. Confirm it still matches the approved baseline.
2. Enter Home Screen editing with the available documented UI controls. Consult Apple's [moving apps and widgets](https://support.apple.com/guide/iphone/move-apps-and-widgets-on-the-home-screen-iphd2fc8ce30/ios) and [folders](https://support.apple.com/guide/iphone/organize-your-apps-in-folders-iph822ece7dd/ios) instructions if needed; they describe user interactions, not a Codex automation API.
3. Make one move at a time within a small independently verifiable batch. Use coordinates or targets grounded in the current observation, not remembered screen geometry. Re-observe after every drag/drop and before the next gesture. Check neighboring icons and page reflow as well as the moved item. Prefer one-icon drags over multi-icon operations.
4. Record each verified change against the ledger. Check the full affected page/folder and protected Dock/widgets at batch boundaries. Continue only while the result matches the approved plan.

**Stop on an uncertain drag, unexpected menu, wrong target, accidental app opening, connection loss, stale view, or unexpected reflow.** Do not repeat blind gestures or chain speculative repairs. Re-observe safely, report verified versus uncertain changes, and ask for user intervention or approval of a revised plan. Authentication interruptions belong to the user. After reconnection, reconcile the current layout before resuming; do not replay completed actions.

Do not delete, uninstall, offload, lock, or hide apps; remove icons from the Home Screen; reset the Home Screen; alter page visibility; or edit App Library categories. App Library categories are managed automatically, not user-editable folders. This skill also excludes changing widget data/configuration, Focus, Lock Screen, wallpaper, notifications, accounts, authentication settings, or app data. Requests for those changes require a separate, appropriately scoped workflow.

## 6. Verify and close

Exit edit mode using the visible supported control. Revisit every changed page/folder and compare it with the approved layout and ledger. Check protected items, folder names/membership, and displaced neighbors. Do not open apps to test them or claim to have audited their internal data.

Report **completed**, **not completed**, and **not verified**, with any mismatch. Completion means the approved visible layout was re-observed, not merely that gestures were issued. If the user wants to undo changes, propose reverse moves from the recorded state and obtain approval; explain that manual reconstruction may be needed and full restoration is not guaranteed. Never use a Home Screen reset as rollback.

For a shareable explanation, describe the process and prerequisites only. Do not export the user's actual app inventory, screenshots, or personal information.
