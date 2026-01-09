# Pentagon Pizza Index (PizzINT) Tidbyt App

A Tidbyt app that monitors and displays the real-time DEFCON level from [pizzint.watch](https://www.pizzint.watch/), the Pentagon Pizza Index.

## Features

- Real-time DEFCON level monitoring (1-5)
- Dynamic color scheme based on alert level:
  - **DEFCON 5**: Blue (normal/peaceful)
  - **DEFCON 4**: Cyan (low alert)
  - **DEFCON 3**: Yellow (increased readiness)
  - **DEFCON 2**: Orange (high alert)
  - **DEFCON 1**: Red (maximum alert)
- Retro military-style display with:
  - Dark brown background with scanlines
  - Colored border matching DEFCON level
  - Exclamation icon
  - Status text lines
  - Pizza sprite

## Setup

### Prerequisites

- [Pixlet](https://tidbyt.dev/docs/overview/getting-started) installed
- A Tidbyt device

### Installation

1. Clone or download this repository
2. Navigate to the project directory

### Testing Locally

Render the app to preview it:

```bash
pixlet render pizzint.star
```

Serve the app locally to view in browser:

```bash
pixlet serve pizzint.star
```

Then open `http://localhost:8080` in your browser.

## Deployment

### Get Your Device ID and API Key

1. Open the Tidbyt mobile app
2. Go to Settings > General > Get API Key
3. Note your Device ID and API Key

### Push to Your Tidbyt

```bash
pixlet push --api-token <YOUR_API_KEY> --installation-id pizzint <YOUR_DEVICE_ID> pizzint.webp
```

Replace:
- `<YOUR_API_KEY>` with your API key from the Tidbyt app
- `<YOUR_DEVICE_ID>` with your device ID

### Configure Refresh Interval

The app is configured to update every 15 minutes by default (see `manifest.yaml`). You can adjust this in the Tidbyt app settings after installation.

## How It Works

1. The app fetches data from `https://www.pizzint.watch/`
2. Parses the HTML to extract the current DEFCON level
3. Extracts status text (e.g., "ROUND HOUSE", "INCREASE IN FORCE READINESS")
4. Displays the information with a retro military-style interface
5. Colors change dynamically based on the DEFCON level

## Visual Design

The app features a retro military alert display style:
- **Title**: "PENTAGON PIZZA INDEX" at the top
- **DEFCON Level**: Prominently displayed with exclamation icon
- **Status Lines**: Descriptive text with bullet points
- **Colors**: Dynamic based on alert level
- **Background**: Dark brown with scanline effect
- **Border**: Colored border matching DEFCON level

## Troubleshooting

### App Shows "ERROR FETCHING DATA"

- Check your internet connection
- Verify pizzint.watch is accessible
- The app will default to DEFCON 3 if fetch fails

### Colors Not Changing

- Ensure the DEFCON level is being parsed correctly
- Check that the level is between 1-5
- Verify the color mapping function is working

### Layout Issues

- The Tidbyt display is 64x32 pixels - text may need truncation
- Adjust font sizes in the code if text doesn't fit
- Check padding and spacing values

## Development

### File Structure

- `pizzint.star` - Main Starlark app file
- `manifest.yaml` - App metadata and configuration
- `README.md` - This file

### Customization

You can customize:
- Color schemes in `get_defcon_color()` function
- Font sizes and styles
- Layout spacing and padding
- Status text parsing patterns
- Refresh interval in `manifest.yaml`

## Notes

- The app scrapes data from pizzint.watch - be respectful of their servers
- HTML parsing may need updates if the website structure changes
- Default refresh is every 15 minutes to avoid overwhelming the server

## License

This project is provided as-is for personal use.

## Credits

- Data source: [pizzint.watch](https://www.pizzint.watch/)
- Built with [Pixlet](https://github.com/tidbyt/pixlet)
