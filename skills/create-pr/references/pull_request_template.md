# Source

Copied from repository file `.github/pull_request_template.md`.
Refresh this reference when the repository template changes.

## Summary
<!-- Provide 2-3 bullet points summarizing the key changes and their purpose -->
- 
- 
- 

## Changes
<!-- List the specific changes made, grouped by component or functionality -->
- **Component/Feature**: Description of changes
- **Another Component**: Description of changes
- 

## Test Plan
<!-- Checklist of tests to validate the changes -->
- [ ] Test item 1
- [ ] Test item 2
- [ ] Test item 3

## Related Issues
<!-- Link any related issues, PRs, or documentation -->
- Closes #
- Related to #
- Docs: 

## How to Test
<!-- Provide step-by-step instructions to test the changes -->
```bash
# Build the workspace
colcon build --packages-select <package_name>

# Run tests
colcon test --packages-select <package_name>

# Launch the system
ros2 launch <package_name> <launch_file>.launch.py
```

## Screenshots/Videos
<!-- If applicable, add screenshots or videos to demonstrate the changes -->

## Additional Notes
<!-- Any additional context, design decisions, or concerns for reviewers -->
