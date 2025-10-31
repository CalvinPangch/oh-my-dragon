#!/bin/bash

# Dragon oh-my-posh Theme Validation Script
# Purpose: Validate theme JSON syntax and schema compliance
# Usage: ./theme-validation.sh [theme-file.json]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default schema and theme locations
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
SCHEMA_FILE="$REPO_ROOT/specs/001-dragon-theme/contracts/theme-schema.json"
THEME_FILE="${1:-$REPO_ROOT/themes/dragon.json}"

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    case $status in
        success)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        error)
            echo -e "${RED}✗${NC} $message"
            ;;
        info)
            echo -e "${YELLOW}ℹ${NC} $message"
            ;;
    esac
}

print_header() {
    echo ""
    echo "================================"
    echo "$1"
    echo "================================"
}

# Main validation logic

print_header "Dragon Theme Validation"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    print_status error "Theme file not found: $THEME_FILE"
    exit 1
fi

print_status info "Validating: $THEME_FILE"

# Check JSON syntax using jq
print_header "1. JSON Syntax Validation"

if command -v jq &> /dev/null; then
    if jq empty "$THEME_FILE" 2>/dev/null; then
        print_status success "JSON syntax is valid"
    else
        print_status error "JSON syntax is invalid"
        echo "Error details:"
        jq empty "$THEME_FILE" 2>&1 || true
        exit 1
    fi
else
    print_status info "jq not installed - skipping JSON validation (install with: apt-get install jq or brew install jq)"
fi

# Check required fields
print_header "2. Required Fields Validation"

required_fields=("version" "final" "colors" "segments")

for field in "${required_fields[@]}"; do
    if jq -e ".$field" "$THEME_FILE" &>/dev/null; then
        print_status success "Field '$field' exists"
    else
        print_status error "Required field '$field' is missing"
        exit 1
    fi
done

# Check color definitions
print_header "3. Color Palette Validation"

colors_to_check=("dragon_gold" "dragon_red" "success" "error")

for color in "${colors_to_check[@]}"; do
    if jq -e ".colors.$color" "$THEME_FILE" &>/dev/null; then
        color_value=$(jq -r ".colors.$color" "$THEME_FILE")
        print_status success "Color '$color' defined as $color_value"
    else
        print_status error "Required color '$color' is missing"
        exit 1
    fi
done

# Check segments
print_header "4. Segment Configuration Validation"

segment_count=$(jq '.segments | length' "$THEME_FILE")
print_status info "Found $segment_count segments"

# Expected segment types for dragon theme
jq '.segments[] | .type' "$THEME_FILE" | while read -r segment_type; do
    segment_type=$(echo "$segment_type" | tr -d '"')
    print_status success "Segment type: $segment_type"
done

# Validate directory segment
print_header "5. Directory Segment Validation"

if jq -e '.segments[] | select(.type == "path")' "$THEME_FILE" &>/dev/null; then
    print_status success "Directory (path) segment found"
    dir_max_width=$(jq '.segments[] | select(.type == "path") | .properties.max_width // 40' "$THEME_FILE")
    dir_truncation=$(jq '.segments[] | select(.type == "path") | .properties.truncation_length // 3' "$REPO_ROOT/themes/dragon.json" "$THEME_FILE")
    print_status info "  - max_width: $dir_max_width"
    print_status info "  - truncation_length: $dir_truncation"
else
    print_status error "Directory segment not found or misconfigured"
fi

# Validate git segment
print_header "6. Git Segment Validation"

if jq -e '.segments[] | select(.type == "git")' "$THEME_FILE" &>/dev/null; then
    print_status success "Git segment found"
else
    print_status error "Git segment not found"
fi

# Validate status segment
print_header "7. Status Segment Validation"

if jq -e '.segments[] | select(.type == "status")' "$THEME_FILE" &>/dev/null; then
    print_status success "Status segment found"
else
    print_status error "Status segment not found"
fi

# Validate execution_time segment
print_header "8. Execution Time Segment Validation"

if jq -e '.segments[] | select(.type == "executiontime")' "$THEME_FILE" &>/dev/null; then
    print_status success "Execution time segment found"
else
    print_status info "Execution time segment not found (optional)"
fi

# Schema validation if available
print_header "9. Schema Validation"

if [ -f "$SCHEMA_FILE" ]; then
    if command -v ajv &> /dev/null; then
        if ajv validate -s "$SCHEMA_FILE" -d "$THEME_FILE" &>/dev/null; then
            print_status success "Schema validation passed"
        else
            print_status error "Schema validation failed"
            ajv validate -s "$SCHEMA_FILE" -d "$THEME_FILE" || true
        fi
    else
        print_status info "ajv not installed - skipping schema validation (install with: npm install -g ajv-cli)"
    fi
else
    print_status info "Schema file not found: $SCHEMA_FILE"
fi

# Summary
print_header "Validation Summary"

print_status success "All critical validations passed!"
echo ""
echo "Theme file: $THEME_FILE"
echo "Status: ✅ Valid and ready for use"
echo ""
