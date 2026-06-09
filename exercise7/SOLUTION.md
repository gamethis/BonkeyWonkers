
## 📄 Summary of Github Action

### 1. `Bonkey-Check.yaml`

```yaml
name: Bonkey-Check

on:
  schedule:
    - cron: '0 0 * * 0'
  workflow_dispatch:
    
jobs:
  check-file:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Verfiy Bonkey File
        run: |
          if [ -f "./exercise7/BonkeyContainers.yaml" ]; then
            echo "Success: BonkeyContainers.yaml is present!"
            exit 0
          else
            echo "Error: BonkeyContainers.yaml is missing!"
            exit 1
          fi
  check:
    runs-on: ubuntu-latest
    steps:
      - name: FRR Release
        run: |

          # Fetch FRR Version
          LATEST_RELEASE=$(curl -s https://api.github.com/repos/FRRouting/frr/releases | jq '.[0] | .tag_name')

          # Print the version to terminal
          echo "----------------------------------------"
          echo "Latest Released Version of FRR: $LATEST_RELEASE"
          echo "----------------------------------------"
```